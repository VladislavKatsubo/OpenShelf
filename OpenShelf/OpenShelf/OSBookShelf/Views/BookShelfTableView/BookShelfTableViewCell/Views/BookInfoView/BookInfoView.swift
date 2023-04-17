//
//  BookInfoView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 16.04.23.
//

import UIKit

final class BookInfoView: OView {

    private enum Constants {
        static let titleLabelFont: UIFont = .systemFont(ofSize: 18.0, weight: .bold)
        static let authorNameAndFirstPublicationYearFont: UIFont = .systemFont(ofSize: 14.0, weight: .thin)

        static let titleLabelNumberOfLines: Int = 0
        static let authorNameAndFirstPublicationYearNumberOfLines: Int = 0

        static let authorLabelTopOffset: CGFloat = 4.0
    }

    private let titleLabel = UILabel()
    private let authorNameAndFirstPublicationYearLabel = UILabel()

    // MARK: - Configure
    func configure(with model: Model) {
        self.titleLabel.text = model.title
        self.authorNameAndFirstPublicationYearLabel.text = model.authorInfoText
    }

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Public methods
    func reset() {
        titleLabel.text = nil
        authorNameAndFirstPublicationYearLabel.text = nil
    }
}

private extension BookInfoView {
    // MARK: - Private methods
    func setupItems() {
        setupTitleLabel()
        setupAuthorYearLabel()
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.font = Constants.titleLabelFont
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func setupAuthorYearLabel() {
        addSubview(authorNameAndFirstPublicationYearLabel)
        authorNameAndFirstPublicationYearLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameAndFirstPublicationYearLabel.font = Constants.authorNameAndFirstPublicationYearFont
        authorNameAndFirstPublicationYearLabel.adjustsFontSizeToFitWidth = true
        authorNameAndFirstPublicationYearLabel.numberOfLines = Constants.authorNameAndFirstPublicationYearNumberOfLines

        NSLayoutConstraint.activate([
            authorNameAndFirstPublicationYearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.authorLabelTopOffset),
            authorNameAndFirstPublicationYearLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            authorNameAndFirstPublicationYearLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            authorNameAndFirstPublicationYearLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private extension BookInfoView.Model {
    var authorInfoText: String? {
        switch (authorName, firstPublicationYear) {
        case let (author?, year?):
            return "by \(author), \(year)"
        case let (author?, .none):
            return "by \(author)"
        case let (.none, year?):
            return "\(year)"
        case (.none, .none):
            return nil
        }
    }
}
