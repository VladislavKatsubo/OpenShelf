//
//  BookShelfProfileIconView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import UIKit

final class BookShelfProfileIconView: OView {
    private enum Constants {

    }

    private let imageView = UIImageView()

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with image: UIImage?) {
        self.imageView.image = image
    }
}

private extension BookShelfProfileIconView {
    // MARK: - Private methods
    func setupItems() {
        clipsToBounds = true
        setupImageView()
    }

    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}

