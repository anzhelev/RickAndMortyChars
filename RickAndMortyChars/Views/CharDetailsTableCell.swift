//
//  CharDetailsTableCell.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 19.10.2024.
//
import UIKit

final class CharDetailsTableCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "charDetailsTableCell"
    
    // MARK: - Private Properties
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with values: CharacterDetail) {
        titleLabel.text = values.detail
        valueLabel.text = values.value
    }
    
    private func setUIElements() {
        backgroundColor = .clear
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)        
        
        titleLabel.font = .detailsMain
        titleLabel.textColor = .primaryTextColor
        
        valueLabel.font = .detailsSupplementary
        valueLabel.textColor = .secondaryTextColor
        
        [titleLabel, valueLabel].forEach {
            $0.textAlignment = .left
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
            
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
        
        titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: centerYAnchor).isActive=true
    }
}
