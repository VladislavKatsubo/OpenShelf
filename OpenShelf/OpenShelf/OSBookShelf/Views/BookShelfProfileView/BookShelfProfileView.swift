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
    }

    private let nameLabel = UILabel()

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with model: Model) {

    }
}

private extension BookShelfProfileView {
    // MARK: - Private methods
    func setupItems() {
        
        setupNameLabel()
    }

    func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Constants.nameLabelFont
    }
}

extension BookShelfProfileView {
    struct Model {
        let title: String?
        let image: UIImage
    }
}
