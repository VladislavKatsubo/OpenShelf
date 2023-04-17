//
//  BookCoverImageView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import UIKit

final class BookCoverImageView: OView {

    private enum Constants {
        static let bookCoverImageViewSize: CGSize = .init(width: 180.0, height: 250.0)
    }

    private let bookCoverImageView = BookCoverView()
    
    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with imageData: Data?) {
        self.bookCoverImageView.configure(with: imageData)
    }
}

private extension BookCoverImageView {
    // MARK: - Private methods
    func setupItems() {
        setupImageView()
    }

    func setupImageView() {
        addSubview(bookCoverImageView)
        bookCoverImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bookCoverImageView.topAnchor.constraint(equalTo: topAnchor),
            bookCoverImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bookCoverImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bookCoverImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookCoverImageView.widthAnchor.constraint(equalToConstant: Constants.bookCoverImageViewSize.width),
            bookCoverImageView.heightAnchor.constraint(equalToConstant: Constants.bookCoverImageViewSize.height)
        ])
    }
}

