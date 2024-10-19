//
//  CharDetailsViewModel.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//
import Foundation

class CharDetailsViewModel {
    
    // MARK: - Puplic Properties
    var setValues: Observable<Bool> = Observable(false)
    
    var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    func viewDidLoad() {
        setValues.value = true
    }
    
    func getCharPictureUrl()  -> URL? {
        URL(string: character.image) ?? nil
    }
    
    func getTableRowCount() -> Int {
        7
    }
    
    func getCellValues(row: Int) -> CharacterDetail {
        switch row {
        case 0:
                .init(detail: .characterName, value: character.name == "" ? "-" : character.name)
        case 1:
                .init(detail: .characterGender, value: character.gender == "" ? "-" : character.gender)
        case 2:
                .init(detail: .characterSpecies, value: character.species == "" ? "-" : character.species)
        case 3:
                .init(detail: .characterType, value: character.type == "" ? "-" : character.type)
        case 4:
                .init(detail: .characterOriginName, value: character.originName == "" ? "-" : character.originName)
        case 5:
                .init(detail: .characterLocationName, value: character.locationName == "" ? "-" : character.locationName)
        default:
                .init(detail: .characterStatus, value: character.status == "" ? "-" : character.status)
        }
    }
}
