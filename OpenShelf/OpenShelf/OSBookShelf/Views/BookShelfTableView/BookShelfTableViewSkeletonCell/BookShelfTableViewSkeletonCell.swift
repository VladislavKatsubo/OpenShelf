//
//  BookShelfTableViewSkeletonCell.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import UIKit

final class BookShelfTableViewSkeletonCell: UITableViewCell {
    static var reuseID: String { String(describing: self) }

    private enum Constants {
        static let containerViewCornerRadius: CGFloat = 30.0
        static let containerViewHeight: CGFloat = 120.0
        static let containerViewBottomInset: CGFloat = -15.0

        static let coverImageViewLeadingOffset: CGFloat = 20.0
        static let coverImageViewBottomInset: CGFloat = -20.0
        static let coverImageViewWidth: CGFloat = 90.0
        static let coverImageViewHeight: CGFloat = 130.0
    }

    private let containerView = SkeletonView()
    private let coverImageView = SkeletonView()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BookShelfTableViewSkeletonCell {
    // MARK: - Private methods
    func setupItems() {
        selectionStyle = .none
        backgroundColor = .clear

        setupContainerView()
        setupCoverView()
    }

    func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius
        containerView.backgroundColor = .white

        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: Constants.containerViewHeight),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.containerViewBottomInset),
        ])
    }

    func setupCoverView() {
        addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.coverImageViewLeadingOffset),
            coverImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.coverImageViewBottomInset),
            coverImageView.widthAnchor.constraint(equalToConstant: Constants.coverImageViewWidth),
            coverImageView.heightAnchor.constraint(equalToConstant: Constants.coverImageViewHeight)
        ])
    }
}
