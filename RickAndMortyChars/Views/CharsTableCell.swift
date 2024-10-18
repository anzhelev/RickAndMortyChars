//
//  CharsTableCell.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//

import Kingfisher
import UIKit

final class CharsTableCell: UITableViewCell {

    // MARK: - Public Properties
    static let reuseIdentifier = "charsTableCell"

    // MARK: - Private Properties
    private var avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let genderLabel = UILabel()
    private let bgView = UIView()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUIElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func configure(with params: CellParams) {

        nameLabel.text = String(params.name)

        if let url = URL(string: params.picture) {
            updateCharPicture(url: url)
        }

        nameLabel.text = params.name
        genderLabel.text = String(params.gender)
    }

    // MARK: - Private Methods
    private func updateCharPicture(url: URL) {
        avatarImageView.kf.indicatorType = .activity

        avatarImageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person.fill")?.withTintColor(.avatarStubTintColor)
        )
    }

    private func setUIElements() {

        selectionStyle = .none

        bgView.backgroundColor = .cellBackground
        bgView.layer.cornerRadius = 16
        bgView.layer.masksToBounds = true

        avatarImageView = UIImageView(image: UIImage(systemName: "person.fill")?.withTintColor(.avatarStubTintColor))
        avatarImageView.backgroundColor = .clear
        avatarImageView.layer.cornerRadius = 14
        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFill

        nameLabel.font = .titleMain
        nameLabel.textAlignment = .left
        nameLabel.textColor = .primaryTextColor
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakStrategy = .hangulWordPriority
        nameLabel.lineBreakMode = .byWordWrapping

        genderLabel.font = .titleSupplementary
        genderLabel.textAlignment = .left
        genderLabel.textColor = .secondaryTextColor

        [bgView, avatarImageView, nameLabel, genderLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            bgView.heightAnchor.constraint(equalTo: heightAnchor, constant: -4),
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),

            avatarImageView.heightAnchor.constraint(equalTo: bgView.heightAnchor, constant: -8),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 4),
            
            nameLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: bgView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -4),

            genderLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            genderLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            genderLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
}
