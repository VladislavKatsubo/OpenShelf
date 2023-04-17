//
//  BookRatingView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import UIKit

final class BookRatingView: OView {

    private enum Constants {
        static let fontSize: CGFloat = 14.0
        static let starImage: UIImage? = UIImage(
            systemName: "star.fill"
        )?.withRenderingMode(
            .alwaysOriginal
        ).withTintColor(
            .systemOrange
        )
        static let starImageViewLeadingOffset: CGFloat = 3.0
    }

    private let ratingLabel = UILabel()
    private let starImageView = UIImageView()

    // MARK: - Configure
    func configure(with rating: String?) {
        guard let rating = rating else { return }
        self.ratingLabel.text = rating
        self.starImageView.image = Constants.starImage
    }

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Public methods
    func reset() {
        ratingLabel.text = nil
        starImageView.image = nil
    }
}

private extension BookRatingView {
    // MARK: - Private methods
    func setupItems() {
        setupLabel()
        setupStarImageView()
    }

    func setupLabel() {
        addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = .systemFont(ofSize: Constants.fontSize, weight: .ultraLight)

        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupStarImageView() {
        addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            starImageView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: Constants.starImageViewLeadingOffset),
            starImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starImageView.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            starImageView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor)
        ])
    }
}
