//
//  CharDetailsViewController.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//
import UIKit

class CharDetailsViewController: UIViewController, AssemblerProtocol {
    
    // MARK: - Public Properties
    var viewModel: CharDetailsViewModel?
    var coordinator: AppCoordinator?
    
    // MARK: - Private Properties
    private let charAvatar: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatarPlaceholder"))
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.secondaryTextColor.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var charDetailsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let charDetailsTableRowHeight = 45.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        configView()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Public Methods
    func bindViewModel() {
        viewModel?.setValues.bind { [weak self] setValues in
            guard let self, let setValues else {
                return
            }
            if setValues {
                self.setValues()
            }
        }
    }
    
    // MARK: - Private Methods
    private func configView() {
        view.backgroundColor = .backgroundColor
        
        setAvatarImageView()
        setDetailsTable()
    }
    
    private func setAvatarImageView() {
        view.addSubview(charAvatar)
        charAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        charAvatar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        charAvatar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        charAvatar.widthAnchor.constraint(equalTo: charAvatar.heightAnchor).isActive = true
    }
    
    private func setDetailsTable() {
        charDetailsTable.register(CharDetailsTableCell.self, forCellReuseIdentifier: CharDetailsTableCell.reuseIdentifier)
        charDetailsTable.delegate = self
        charDetailsTable.dataSource = self
        view.addSubview(charDetailsTable)
        
        charDetailsTable.topAnchor.constraint(equalTo: charAvatar.bottomAnchor, constant: 20).isActive = true
        charDetailsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        charDetailsTable.leadingAnchor.constraint(equalTo: charAvatar.leadingAnchor).isActive = true
        charDetailsTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
    }
    
    private func setValues() {
        updateCharPicture(url: viewModel?.getCharPictureUrl())
        charDetailsTable.reloadData()
    }
    
    private func updateCharPicture(url: URL?) {
        guard let url else {
            return
        }
        charAvatar.kf.indicatorType = .activity
        
        charAvatar.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person.fill")
        )
        print (url)
    }
}

// MARK: - UITableViewDataSource
extension CharDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getTableRowCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharDetailsTableCell.reuseIdentifier,
            for: indexPath
        ) as? CharDetailsTableCell else {
            debugPrint("@@@ StatisticsViewController: Ошибка подготовки ячейки для таблицы.")
            return UITableViewCell()
        }
        
        if let viewModel {
            let values = viewModel.getCellValues(row: indexPath.row)
            cell.configure(with: values)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        charDetailsTableRowHeight
    }
}
