//
//  CharListViewController.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//
import UIKit

class CharListViewController: UIViewController, AssemblerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var charsTable: UITableView!
    
    // MARK: - Public Properties
    var viewModel: CharListViewModel?
    weak var coordinator: AppCoordinator?
    
    // MARK: - Private Properties
    private var activityIndicator = UIActivityIndicatorView()
    
    private let charsTableRowHeight = 100.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel?.viewWillAppear()
    }
    
    // MARK: - Public Methods
    
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func updateTable(with indexes: [IndexPath]) {
        charsTable.insertRows(at: indexes, with: .automatic)
    }
    
    
    // MARK: - Private Methods
    private func bindViewModel() {
        viewModel?.showIndicator.bind{ [weak self] showIndicator in
            guard let self, let showIndicator else {
                return
            }
            DispatchQueue.main.async {
                if showIndicator {
                    self.showLoading()
                } else {
                    self.hideLoading()
                }
            }
        }
        
        viewModel?.newRowsAdded.bind{ [weak self] newRowsAdded in
            guard let self, let newRowsAdded else {
                return
            }
            self.updateTable(with: newRowsAdded)
        }
    }
    
    private func configView() {
        
        setupActivityIndicator()
        setupCharsTable()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .secondaryTextColor
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupCharsTable() {
        charsTable.register(CharsTableCell.self, forCellReuseIdentifier: CharsTableCell.reuseIdentifier)
        charsTable.delegate = self
        charsTable.dataSource = self
        charsTable.separatorStyle = .none
        charsTable.showsVerticalScrollIndicator = false
    }
}

// MARK: - UITableViewDataSource
extension CharListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getTableRowCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharsTableCell.reuseIdentifier,
            for: indexPath
        ) as? CharsTableCell else {
            debugPrint("@@@ StatisticsViewController: Ошибка подготовки ячейки для таблицы.")
            return UITableViewCell()
        }
        
        if let viewModel {
            let params = viewModel.getParams(for: indexPath.row)
            cell.configure(with: params)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        charsTableRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.charIsSelected (row: indexPath.row)
    }
}
