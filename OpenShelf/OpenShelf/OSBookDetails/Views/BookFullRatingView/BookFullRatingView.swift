
//  BookFullRatingView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import UIKit

final class BookFullRatingView: OView {

    private enum Constants {
        static let fontSize: CGFloat = 20.0
        static let ratingsCountFontSize: CGFloat = 14.0
        static let starImage: UIImage? = UIImage(
            systemName: "star.fill"
        )?.withRenderingMode(
            .alwaysOriginal
        ).withTintColor(
            .systemOrange
        )
        static let halfStarImage: UIImage? = UIImage(
            systemName: "star.leadinghalf.filled"
        )?.withRenderingMode(
            .alwaysOriginal
        ).withTintColor(
            .systemOrange
        )
        static let ratingLabelTopOffset: CGFloat = 5.0
        static let ratingLabelFont: UIFont = .systemFont(ofSize: Constants.fontSize, weight: .semibold)
        static let ratingsCountLabelFont: UIFont = .systemFont(ofSize: Constants.ratingsCountFontSize, weight: .light)
        static let ratingsCountLabelTopOffset: CGFloat = 5.0
        static let ratingsCountLabelBottomInset: CGFloat = -10.0

        static let shadowColor: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        static let shadowOpacity: Float = 1.0
        static let shadowRadius: CGFloat = 4.0
        static let shadowOffset: CGSize = CGSize(width: 5, height: 5)

        static let stackViewTopOffset: CGFloat = 10.0

        static let cornerRadius: CGFloat = 10.0
    }

    private let containerView = OView()
    private let stackView = OStackView(axis: .horizontal)
    private let ratingLabel = UILabel()
    private let ratingsCountLabel = UILabel()
    private let shadowView = UIView()

    // MARK: - Configure
    func configure(with model: Model) {
        guard let rating = model.rating else { return }
        self.setupStars(for: rating)
        self.ratingLabel.text = String(format: "%.2f", rating)

        guard let ratingsCount = model.ratingsCount else { return }
        self.ratingsCountLabel.text = "based on \(ratingsCount) reviews"
    }

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: Constants.cornerRadius).cgPath
    }
}

private extension BookFullRatingView {
    // MARK: - Private methods
    func setupItems() {
        setupContainerView()
        setupStackView()
        setupRatingLabel()
        setupRatingsCountLabel()
    }

    func setupContainerView() {
        addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.shadowColor = Constants.shadowColor
        shadowView.layer.shadowOpacity = Constants.shadowOpacity
        shadowView.layer.shadowRadius = Constants.shadowRadius
        shadowView.layer.shadowOffset = Constants.shadowOffset

        addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.clipsToBounds = true

        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),

            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }


    func setupStackView() {
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.stackViewTopOffset),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }

    func setupRatingLabel() {
        containerView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = Constants.ratingLabelFont
        ratingLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.ratingLabelTopOffset),
            ratingLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }

    func setupRatingsCountLabel() {
        containerView.addSubview(ratingsCountLabel)
        ratingsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsCountLabel.font = Constants.ratingsCountLabelFont
        ratingsCountLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            ratingsCountLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: Constants.ratingsCountLabelTopOffset),
            ratingsCountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ratingsCountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.ratingsCountLabelBottomInset)
        ])
    }

    func setupStars(for rating: Double) {
        for _ in 0..<Int(rating) {
            let imageView = UIImageView.init(image: Constants.starImage)
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            stackView.addArrangedSubview(imageView)
        }
        if rating.truncatingRemainder(dividingBy: 1.0) > 0 {
            let imageView = UIImageView.init(image: Constants.halfStarImage)
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            stackView.addArrangedSubview(imageView)
        }
    }
}
