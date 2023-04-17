//
//  BookCoverView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import UIKit

final class BookCoverView: OView {

    private enum Constants {
        static let fontSize: CGFloat = 14.0
        static let starImageViewLeadingOffset: CGFloat = 3.0
        static let cornerRadius: CGFloat = 10.0

        static let shadowColor: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        static let shadowOpacity: Float = 1.0
        static let shadowRadius: CGFloat = 4.0
        static let shadowOffset: CGSize = CGSize(width: 5, height: 5)
    }

    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let coverImageView = UIImageView()
    private let containerView = UIView()

    // MARK: - Configure
    func configure(with image: UIImage?) {
        guard let image = image else {
            return
        }
        self.activityIndicator.stopAnimating()
        self.coverImageView.image = image
        setupShadowLayer()
    }

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Public methods
    func reset() {
        self.coverImageView.image = nil
        self.activityIndicator.startAnimating()
        self.containerView.layer.shadowOpacity = 0
    }
}

private extension BookCoverView {
    // MARK: - Private methods
    func setupItems() {
        setupContainerView()
        setupCoverImageView()
        setupActivityIndicator()
    }

    func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.clipsToBounds = true

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func setupShadowLayer() {
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = Constants.shadowColor
        containerView.layer.shadowOpacity = Constants.shadowOpacity
        containerView.layer.shadowRadius = Constants.shadowRadius
        containerView.layer.shadowOffset = Constants.shadowOffset
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: containerView.layer.cornerRadius).cgPath
    }

    func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupCoverImageView() {
        containerView.addSubview(coverImageView)
        coverImageView.layer.cornerRadius = Constants.cornerRadius
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
