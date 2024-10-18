//
//  Coordinator.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    func start ()
}
