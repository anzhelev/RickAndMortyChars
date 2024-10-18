//
//  Untitled.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//
import Foundation

class CharListViewModel {
    
    // MARK: - Puplic Properties
    var showIndicator: Observable<Bool> = Observable(false)
    var newRowsAdded: Observable<[IndexPath]> = Observable(nil)
    
    // MARK: - Private Properties
    private let networkClient = NetworkClient.networkClient
    private var characters = [Character]()
    private var nextPageUrl: String? = RequestConstants.baseUrl
    private var itemsLoaded = 0
    private var nextPageRequested = false
    private var state: CharListViewModelState? {
        didSet {
            stateDidChanged()
        }
    }
    
    // MARK: - States
    private enum CharListViewModelState {
        case loadNextPage,                // стейт запроса данных или сети
             loadFailed(Error),           // стейт обработки ошибки при неудачной загрузке данных
             dataLoaded(CharactersData)   // стейт обработки данных при удачной загрузке
    }
    
    // MARK: - Public Methods
    func viewWillAppear() {
        state = .loadNextPage
    }
    
    func getTableRowCount() -> Int {
        characters.count
    }
    
    func getParams(for row: Int) -> CellParams {
        checkIfANewPageIsNeeded(currentRow: row)
        
        return .init(
            name: characters[row].name,
            gender: characters[row].gender,
            picture: characters[row].image
        )
    }
    
    func charIsSelected (row: Int) {
    }
    
    // MARK: - Public Methods
    private func stateDidChanged() {
        switch state {
            
        case .loadNextPage:
            if itemsLoaded == 0 {
                showIndicator.value = true
            }
            guard let nextPageUrl else {
                return
            }
            nextPageRequested = true
            networkClient.loadNewPage(requestUrl: nextPageUrl) { [weak self] result in
                self?.showIndicator.value = false
                switch result {
                case .success(let newData):
                    self?.state = .dataLoaded(newData)
                case .failure(let error):
                    self?.state = .loadFailed(error)
                }
            }
            
        case .loadFailed(let error):
            nextPageRequested = false
            //TODO: добавить алерт об ошибке
            
        case .dataLoaded(let newData):
            characters += newData.characters
            var newIndexes = [IndexPath]()
            for newItem in itemsLoaded...characters.count-1 {
                newIndexes.append(IndexPath(row: newItem, section: 0))
            }
            self.newRowsAdded.value = newIndexes
            self.itemsLoaded = characters.count
            self.nextPageUrl = newData.nextPage
            nextPageRequested = false
            
        case .none:
            assertionFailure("StatisticsPresenter can't move to initial state")
        }
    }
    
    private func checkIfANewPageIsNeeded(currentRow: Int) {
        if itemsLoaded - currentRow < 6 && !nextPageRequested {
            state = .loadNextPage
        }
    }
}
