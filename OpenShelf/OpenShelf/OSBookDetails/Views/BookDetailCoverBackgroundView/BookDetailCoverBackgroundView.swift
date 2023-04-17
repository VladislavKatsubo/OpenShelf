//
//  BookDetailCoverBackgroundView().swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import UIKit

final class BookDetailCoverBackgroundView: OView {

    private enum Constants {
        static let titleLabelFont: UIFont = .systemFont(ofSize: 28.0, weight: .heavy)
        static let authorNameLabelFont: UIFont = .systemFont(ofSize: 22.0, weight: .light)
        static let firstPublishedYearLabelFont: UIFont = .systemFont(ofSize: 20.0, weight: .light)
        static let stackViewCenterYOffset: CGFloat = 10.0
        static let stackViewSpacingAfterBookCoverImageView: CGFloat = 30.0
        static let stackViewSpacingAfterTitleLabel: CGFloat = 10.0
        static let stackViewSpacingAfterAuthorNameLabel: CGFloat = 10.0
    }

    private let backgroundCoverImageView = UIImageView()
    private let visualEffectView = UIVisualEffectView()
    private let bookCoverImageView = BookCoverImageView()
    private let titleLabel = UILabel()
    private let authorNameLabel = UILabel()
    private let firstPublishedYearLabel = UILabel()
    private let contentStackView = OStackView(axis: .vertical)

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with model: Model) {
        guard let title = model.title,
              let authorName = model.authorName,
              let firstPublishedYear = model.firstPublishedYear else {
            return
        }
        self.titleLabel.text = title
        self.authorNameLabel.text = "by " + authorName
        self.firstPublishedYearLabel.text = String(firstPublishedYear)
    }

    func configure(with imageData: Data?) {
        guard let imageData = imageData else { return }
        self.bookCoverImageView.configure(with: imageData)

        let image = UIImage(data: imageData)
        self.backgroundCoverImageView.image = image
    }
}

private extension BookDetailCoverBackgroundView {
    // MARK: - Private methods
    func setupItems() {
        setupBackgroundCoverImageView()
        setupVisualEffectView()

        setupContentStackView()
        setupTitleLabel()
        setupAuthorNameLabel()
        setupFirstPublishedYearLabel()
    }

    func setupBackgroundCoverImageView() {
        addSubview(backgroundCoverImageView)
        backgroundCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCoverImageView.contentMode = .scaleAspectFill
        backgroundCoverImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            backgroundCoverImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundCoverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundCoverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundCoverImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupVisualEffectView() {
        addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .regular)
        visualEffectView.effect = blurEffect

        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupContentStackView() {
        visualEffectView.contentView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.alignment = .center

        contentStackView.addArrangedSubview(bookCoverImageView)
        contentStackView.setCustomSpacing(Constants.stackViewSpacingAfterBookCoverImageView, after: bookCoverImageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.setCustomSpacing(Constants.stackViewSpacingAfterTitleLabel, after: titleLabel)
        contentStackView.addArrangedSubview(authorNameLabel)
        contentStackView.setCustomSpacing(Constants.stackViewSpacingAfterAuthorNameLabel, after: authorNameLabel)
        contentStackView.addArrangedSubview(firstPublishedYearLabel)

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor, constant: Constants.stackViewCenterYOffset),
            contentStackView.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor),
        ])
    }

    func setupTitleLabel() {
        titleLabel.font = Constants.titleLabelFont
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
    }

    func setupAuthorNameLabel() {
        authorNameLabel.font = Constants.authorNameLabelFont
        authorNameLabel.textAlignment = .center
        authorNameLabel.textColor = .white
    }

    func setupFirstPublishedYearLabel() {
        firstPublishedYearLabel.font = Constants.firstPublishedYearLabelFont
        firstPublishedYearLabel.textAlignment = .center
        firstPublishedYearLabel.textColor = .white
    }
}
