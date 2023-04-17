//
//  BookDetailsViewController.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import UIKit

final class BookDetailsViewController: UIViewController {

    typealias Constants = BookDetailsResources.Constants.UI

    private var viewModel: BookDetailsViewModelProtocol?

    private let backgroundCoverView = BookDetailCoverBackgroundView()
    private let fullRatingView = BookFullRatingView()
    private let descriptionLabel = UILabel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(viewModel: BookDetailsViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension BookDetailsViewController {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel?.onStateChange = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .onFetchBookDescription(let description):
                self.descriptionLabel.text = description
            case .onFetchBookImageData(let imageData):
                self.backgroundCoverView.configure(with: imageData)
            case .onSetBookInfo(let model):
                self.backgroundCoverView.configure(with: model)
            case .onSetBookRating(let model):
                self.fullRatingView.isHidden = false
                self.fullRatingView.configure(with: model)
            }

        }
        viewModel?.launch()
    }

    func setupItems() {
        view.backgroundColor = .white

        setupBackgroundCoverView()
        setupFullRatingView()
        setupDescriptionLabel()
    }

    func setupBackgroundCoverView() {
        view.addSubview(backgroundCoverView)
        backgroundCoverView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundCoverView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundCoverView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.backgroundCoverImageViewHeightMultiplier)
        ])
    }

    func setupFullRatingView() {
        view.addSubview(fullRatingView)
        fullRatingView.translatesAutoresizingMaskIntoConstraints = false
        fullRatingView.isHidden = true

        NSLayoutConstraint.activate([
            fullRatingView.centerYAnchor.constraint(equalTo: backgroundCoverView.bottomAnchor),
            fullRatingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullRatingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
        ])
    }

    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Constants.descriptionLabelFont
        descriptionLabel.textAlignment = .natural
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: fullRatingView.bottomAnchor, constant: Constants.descriptionLabelTopOffset),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionLabelLeadingOffset),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.descriptionLabelTrailingInset),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.descriptionLabelBottomInset),
        ])
    }
}
