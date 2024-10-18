//
//  CharactersData.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//
import Foundation

struct CharactersData {
    let totalPages: Int
    let nextPage: String?
    let characters: [Character]
}

struct Character {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let originName: String
    let locationName: String
    let image: String
}
