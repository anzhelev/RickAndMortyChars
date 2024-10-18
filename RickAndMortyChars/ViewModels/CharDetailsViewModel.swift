//
//  CharDetailsViewModel.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//

import Foundation

class CharDetailsViewModel {
    
    var character: Character?

    
    
    
    func getCharName() -> String {
        character?.name ?? ""
    }
    
    func getCharPictureUrl()  -> URL? {
        URL(string: character?.image ?? "")
    }
    
    func getCharGender()  -> String {
        character?.gender ?? ""
    }
    
    func getCharStatus()  -> String {
        character?.status ?? ""
    }
    
    func getCharSpecies()  -> String {
        character?.species ?? ""
    }
    
    func getCharOriginName()  -> String {
        character?.originName ?? ""
    }
    
    func getCharLocationName()  -> String {
        character?.locationName ?? ""
    }
    
    func getCharType() -> String {
        character?.type ?? ""
    }
}
