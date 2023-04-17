//
//  BookShelfTableLabel.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 17.04.23.
//

import UIKit

final class BookShelfTableLabel: OView {

    private enum Constants {
        static let font: UIFont = .systemFont(ofSize: 24.0, weight: .heavy)
        static let text: String = "Your shelf:"
        static let leadingOffset: CGFloat = 20.0
    }

    private let label = UILabel()

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }
}

private extension BookShelfTableLabel {
    // MARK: - Private methods
    func setupItems() {
        setupLabel()
    }

    func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.font
        label.text = Constants.text

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

