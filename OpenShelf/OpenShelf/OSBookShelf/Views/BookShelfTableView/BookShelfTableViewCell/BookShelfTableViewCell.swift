//
//  BookShelfTableViewCell.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import UIKit

final class BookShelfTableViewCell: UITableViewCell {
    static var reuseID: String { String(describing: self) }

    private enum Constants {
        static let spacingAfterInfoView: CGFloat = 10.0

        static let containerViewCornerRadius: CGFloat = 30.0

        static let stackViewLeadingOffset: CGFloat = 20.0
        static let stackViewTopOffset: CGFloat = 20.0
        static let stackViewTrailingInset: CGFloat = -20.0

        static let coverImageViewLeadingOffset: CGFloat = 20.0
        static let coverImageViewBottomInset: CGFloat = -20.0
        static let coverImageViewWidth: CGFloat = 90.0
        static let coverImageViewHeight: CGFloat = 130.0

        static let containerViewHeight: CGFloat = 120.0
        static let containerViewBottomInset: CGFloat = -15.0
    }

    private let containerView = OView()
    private let stackView = OStackView(axis: .vertical)
    private let coverImageView = BookCoverView()
    private let infoView = BookInfoView()
    private let ratingView = BookRatingView()

    private var viewModel: BookShelfTableViewCellViewModelProtocol?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cleanup()
    }

    // MARK: - Configure
    func configure(with viewModel: BookShelfTableViewCellViewModelProtocol) {
        self.viewModel = viewModel
        setupViewModel()
    }
}

private extension BookShelfTableViewCell {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel?.onFetchBookCoverImageData = { [weak self] data in
            self?.coverImageView.configure(with: data)
        }
        viewModel?.onGetBookRating = { [weak self] rating in
            self?.ratingView.configure(with: rating)
        }
        viewModel?.onGetBookInfo = { [weak self] model in
            self?.infoView.configure(with: model)
        }
        viewModel?.launch()
    }

    func setupItems() {
        selectionStyle = .none
        backgroundColor = .clear

        setupContainerView()
        setupCoverView()
        setupStackView()
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
        containerView.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.coverImageViewLeadingOffset),
            coverImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.coverImageViewBottomInset),
            coverImageView.widthAnchor.constraint(equalToConstant: Constants.coverImageViewWidth),
            coverImageView.heightAnchor.constraint(equalToConstant: Constants.coverImageViewHeight)
        ])
    }

    func setupStackView() {
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading

        stackView.addArrangedSubview(infoView)
        stackView.setCustomSpacing(Constants.spacingAfterInfoView, after: infoView)
        stackView.addArrangedSubview(ratingView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.stackViewTopOffset),
            stackView.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: Constants.stackViewLeadingOffset),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.stackViewTrailingInset),
            stackView.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor)
        ])
    }

    private func cleanup() {
        viewModel?.cancelImageDownload()
        coverImageView.reset()
        infoView.reset()
        ratingView.reset()
    }
}
