//
//  DataModel.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 17.10.2024.
//
import Foundation

struct FetchedData: Codable {
    let info: Info
    let results: [CharacterData]
}

struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

struct CharacterData: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}
