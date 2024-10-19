//
//   AssemblerProtocol.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//
import UIKit

protocol AssemblerProtocol {
    static func createObject () -> Self
}

extension AssemblerProtocol where Self: UIViewController {
    static func createObject() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: id) as Self
    }
}
