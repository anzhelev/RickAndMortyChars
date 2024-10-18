//
//  NetworkClient.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//

import Foundation

private enum NetworkClientErrors: Error {
    case requestCreationFailure
    case requestFail(Error)
    case wrongServerResponce(String)
    case wrondData
    case JSONDecodeError(Error)
}

final class NetworkClient {
    
    // MARK: - Public Properties
    static let networkClient = NetworkClient()
    var task: URLSessionTask?
    
    // MARK: - Public methods
    /// функция запроса новой страницы
    func loadNewPage(requestUrl: String, completion: @escaping (Result<CharactersData, Error>) -> Void) {
        assert(Thread.isMainThread)
        if task != nil {
            debugPrint("CONSOLE func loadNewPage: Отмена повторного сетевого запроса.")
            return
        }
        
        guard let request = createRequest(for: requestUrl) else {
            debugPrint("CONSOLE func loadNewPage: Ошибка сборки запроса")
            completion(.failure(NetworkClientErrors.requestCreationFailure))
            return
        }
        
        let task = objectTask(for: request) {[weak self] (result: Result<FetchedData, Error>) in
            DispatchQueue.main.async {
                if let self {
                    self.task = nil
                    switch result {
                    case .success(let data):
                        var newItems: [Character] = []
                        for item in data.results {
                            newItems.append(.init(name: item.name,
                                                  status: item.status,
                                                  species: item.species,
                                                  type: item.type,
                                                  gender: item.gender,
                                                  originName: item.origin.name,
                                                  locationName: item.location.name,
                                                  image: item.image
                                                 )
                            )
                        }
                        completion(
                            .success(.init(totalPages: data.info.pages,
                                           nextPage: data.info.next,
                                           characters: newItems
                                          )
                            )
                        )
                        
                    case .failure(let error):
                        debugPrint("CONSOLE func loadNewPage:", error.localizedDescription)
                        completion(.failure(error))
                    }
                }
            }
        }
        self.task = task
    }
    
    /// функция сетевого запроса
    func objectTask<T: Decodable>( for request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let error = error {
                completion(.failure(NetworkClientErrors.requestFail(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkClientErrors.wrongServerResponce("Код ответа сервера: \(response.statusCode)")))
                return
            }
            
            guard let data = data
            else {
                completion(.failure(NetworkClientErrors.wrondData))
                return
            }
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkClientErrors.JSONDecodeError(error)))
                return
            }
        }
        
        task.resume()
        return task
    }
    
    // MARK: - Private methods
    /// функция сбора запроса данных
    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            assertionFailure("Failed to create URL")
            debugPrint("CONSOLE func createRequest: Ошибка сборки URL для сетевого запроса")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
