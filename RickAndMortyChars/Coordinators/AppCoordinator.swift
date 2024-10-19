//
//  Untitled.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showCharList()
    }
    
    func showCharList() {
        let vc = CharListViewController.createObject()
        vc.coordinator = self
        vc.viewModel = CharListViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCharDetails(for character: Character) {
        let vc = CharDetailsViewController.createObject()
        vc.coordinator = self
        vc.viewModel = CharDetailsViewModel(character: character)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismissViewController(vc: UIViewController) {
        vc.dismiss(animated: true)
    }
}
