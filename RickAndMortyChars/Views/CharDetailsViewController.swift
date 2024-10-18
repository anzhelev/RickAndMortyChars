//
//  CharDetailsViewController.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//

import UIKit

class CharDetailsViewController: UIViewController, AssemblerProtocol {
    
    private let charAvatar: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill")?.withTintColor(.avatarStubTintColor))
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let charName = UILabel()
    private let charStatus = UILabel()
    private let charSpecies = UILabel()
    private let charType = UILabel()
    private let charGender = UILabel()
    private let charOriginName = UILabel()
    private let charLocationName = UILabel()
    
    var viewModel: CharDetailsViewModel?
    var coordinator: AppCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        configView()
        
    }
    
    func bindViewModel() {
        //        viewModel.
    }
    
    func configView() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(charAvatar)
        charAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        charAvatar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        charAvatar.heightAnchor.constraint(equalToConstant: 120).isActive = true
        charAvatar.widthAnchor.constraint(equalTo: charAvatar.heightAnchor).isActive = true
        
        let labels = [charName, charStatus, charSpecies, charType, charGender, charOriginName, charLocationName]
        labels.forEach {
            $0.font = .detailsMain
            $0.textColor = .primaryTextColor
            $0.textAlignment = .left
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            
            $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
            $0.leadingAnchor.constraint(equalTo: charAvatar.leadingAnchor).isActive = true
        }
        
        charName.topAnchor.constraint(equalTo: charAvatar.bottomAnchor, constant: 8).isActive = true
        
        labels[1...].enumerated().forEach {index, label in
            label.topAnchor.constraint(equalTo: labels[index-1].bottomAnchor, constant: 8).isActive = true
        }
    }
    
    
    // MARK: - Public Methods
    func setValues(with params: Character) {
        if let viewModel {
            updateCharPicture(url: viewModel.getCharPictureUrl())
            charName.text = .characterName +  ": \(viewModel.getCharName())"
            charStatus.text = .characterStatus +  ": \(viewModel.getCharStatus())"
            charSpecies.text = .characterSpecies +  ": \(viewModel.getCharSpecies())"
            charType.text = .characterType +  ": \(viewModel.getCharType())"
            charGender.text = .characterGender +  ": \(viewModel.getCharGender())"
            charOriginName.text = .characterOriginName +  ": \(viewModel.getCharOriginName())"
            charLocationName.text = .characterLocationName +  ": \(viewModel.getCharLocationName())"
        }
    }
    
    // MARK: - Private Methods
    private func updateCharPicture(url: URL?) {
        guard let url else {
            return
        }
        charAvatar.kf.indicatorType = .activity
        
        charAvatar.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person.fill")?.withTintColor(.avatarStubTintColor)
        )
    }
}
