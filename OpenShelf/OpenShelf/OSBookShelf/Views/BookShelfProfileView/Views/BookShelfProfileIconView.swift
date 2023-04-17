//
//  BookShelfProfileIconView.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import UIKit

final class BookShelfProfileIconView: OView {
    private enum Constants {
        static let color: CGColor = UIColor.black.cgColor
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 15.0
        static let imageViewSize: CGSize = CGSize(width: 45.0, height: 45.0)
    }

    private let imageView = UIImageView()

    // MARK: - Configure
    func configure(with image: UIImage?) {
        self.imageView.image = image
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupItems()
    }
}

private extension BookShelfProfileIconView {
    func setupItems() {
        setupCircle()
        setupImageView()
    }

    func setupCircle() {
        backgroundColor = .white
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.color
        layer.cornerRadius = Constants.cornerRadius
    }

    func setupImageView() {
        addSubview(imageView)
        imageView.contentMode = .center

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize.height)
        ])
    }

}

