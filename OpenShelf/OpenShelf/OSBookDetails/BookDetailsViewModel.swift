//
//  BookDetailsViewModel.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import Foundation

protocol BookDetailsViewModelProtocol {
    var onStateChange: ((BookDetailsResources.State) -> Void)? { get set }
    func launch()
}

final class BookDetailsViewModel: BookDetailsViewModelProtocol {

    typealias Constants = BookDetailsResources.Constants.Mocks

    private let networkManager: NetworkManagerProtocol
    private let imageManager: ImageManagerProtocol

    var onStateChange: ((BookDetailsResources.State) -> Void)?
    private var detailModel: BookDetailsModel

    // MARK: - Init
    init(model: BookShelfTableViewCell.Model, networkManager: NetworkManagerProtocol, imageManager: ImageManagerProtocol) {
        self.networkManager = networkManager
        self.imageManager = imageManager
        self.detailModel = .init(
            key: model.key,
            coverID: model.coverID,
            title: model.title,
            authorName: model.author,
            firstPublishedYear: model.firstPublicationYear,
            averageRating: model.averageRating,
            ratingsCount: model.ratingsCount
        )
    }

    // MARK: - Public methods
    func launch() {
        fetchImageData()
        fetchBookDesctiption()
        fetchBookInfo()
        fetchBookRating()
    }
}

private extension BookDetailsViewModel {
    // MARK: - Private methods
    func fetchBookDesctiption() {
        guard let key = detailModel.key,
              let url = RequestConstructor.Endpoint.description(keyWithEndpoint: key).url() else {
            return
        }

        networkManager.fetchData(url: url, expecting: APIBookDescription.self) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.onStateChange?(.onFetchBookDescription(response.description))
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func fetchImageData() {
        guard let url = RequestConstructor.Endpoint.image(
            coverId: detailModel.coverID,
            imageSize: Constants.imageSizeType
        ).url() else {
            return
        }
        _ = imageManager.fetchImageData(url: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.onStateChange?(.onFetchBookImageData(imageData))
                }
            case .failure(let failure):
                print("BookDetailsViewModel, fetchImageData(), error: ", failure)
            }
        }
    }

    func fetchBookInfo() {
        let model: BookDetailCoverBackgroundView.Model = .init(
            title: detailModel.title,
            authorName: detailModel.authorName,
            firstPublishedYear: detailModel.firstPublishedYear
        )
        onStateChange?(.onSetBookInfo(model))
    }

    func fetchBookRating() {
        let model: BookFullRatingView.Model = .init(
            rating: detailModel.averageRating,
            ratingsCount: detailModel.ratingsCount
        )
        if model.rating != nil {
            onStateChange?(.onSetBookRating(model))
        }
    }
}
