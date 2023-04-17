//
//  BookShelfProfileView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import UIKit

final class BookShelfProfileView: OView {

    private enum Constants {
        static let nameLabelFont: UIFont = .systemFont(ofSize: 28.0, weight: .heavy)
        static let cornerRadius: CGFloat = 30.0
        static let iconViewCornerRadius: CGFloat = 10.0

        static let iconViewTrailingInset: CGFloat = -20.0
        static let iconViewWidth: CGFloat = 45.0
        static let iconViewHeight: CGFloat = 45.0

        static let nameLabelTopOffset: CGFloat = 20.0
        static let nameLabelLeadingOffset: CGFloat = 20.0
        static let nameLabelBottomInset: CGFloat = -20.0
    }

    private let nameLabel = UILabel()
    private let iconView = BookShelfProfileIconView()

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with model: Model) {
        guard let name = model.name,
              let image = model.image
        else {
            return
        }
        self.nameLabel.text = "Hello,\n\(name)!"
        self.iconView.configure(with: image)
    }
}

private extension BookShelfProfileView {
    // MARK: - Private methods
    func setupItems() {
        backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadius

        setupNameLabel()
        setupIconView()
    }

    func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Constants.nameLabelFont
        nameLabel.numberOfLines = 2

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.nameLabelTopOffset),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.nameLabelLeadingOffset),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.nameLabelBottomInset)
        ])
    }

    func setupIconView() {
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.layer.cornerRadius = Constants.iconViewCornerRadius

        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.iconViewTrailingInset),
            iconView.widthAnchor.constraint(equalToConstant: Constants.iconViewWidth),
            iconView.heightAnchor.constraint(equalToConstant: Constants.iconViewHeight)
        ])
    }
}
