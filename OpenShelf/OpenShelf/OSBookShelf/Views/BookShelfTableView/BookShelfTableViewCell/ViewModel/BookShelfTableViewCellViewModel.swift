//
//  BookShelfTableViewCellViewModel.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import Foundation

protocol BookShelfTableViewCellViewModelProtocol {
    var onFetchBookCoverImageData: ((Data) -> Void)? { get set }
    var onGetBookRating: ((Double?) -> Void)? { get set }
    var onGetBookInfo: ((BookInfoView.Model) -> Void)? { get set }
    
    func launch()
    func cancelImageDownload()
}

final class BookShelfTableViewCellViewModel: BookShelfTableViewCellViewModelProtocol {

    private enum Constants {
        static let bookCoverImageSize: String = "M"
    }

    private var imageManager: ImageManagerProtocol?
    private var model: BookShelfTableViewCell.Model?

    var onFetchBookCoverImageData: ((Data) -> Void)?
    var onGetBookRating: ((Double?) -> Void)?
    var onGetBookInfo: ((BookInfoView.Model) -> Void)?

    private var dataTask: URLSessionDataTask?

    // MARK: - Configure
    init(model: BookShelfTableViewCell.Model, imageManager: ImageManagerProtocol) {
        self.model = model
        self.imageManager = imageManager
    }

    // MARK: - Public methods
    func launch() {
        let url = self.constructCoverURL(for: model?.coverID)
        self.dataTask = fetchImage(for: url)
        processRating(with: model?.averageRating)
        processBookInfoViewModel(with: model)
    }

    func cancelImageDownload() {
        if let task = dataTask {
            imageManager?.cancelDataTask(task)
        }
    }
}

private extension BookShelfTableViewCellViewModel {
    // MARK: - Private methods
    func constructCoverURL(for id: Int?) -> URL? {
        let url = RequestConstructor.Endpoint.image(
            coverId: id,
            imageSize: Constants.bookCoverImageSize
        ).url()
        return url
    }

    func fetchImage(for url: URL?) -> URLSessionDataTask? {
        guard let url = url else { return nil }

        let dataTask = imageManager?.fetchImageData(url: url, completion: { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.onFetchBookCoverImageData?(data)
                }
            case .failure(let failure):
                if (failure as NSError).code == NSURLErrorCancelled {
                    // MARK: Prevented the wrong image from being shown by cancelling the URLSessionDataTask
                } else {
                    print("BookShelfTableViewCellViewModel Image fetching failure", failure)
                }
            }
        })
        return dataTask
    }

    func processRating(with rating: Double?) {
        onGetBookRating?(rating)
    }

    func processBookInfoViewModel(with model: BookShelfTableViewCell.Model?) {
        let bookInfoModel: BookInfoView.Model = .init(
            title: model?.title,
            authorName: model?.author,
            firstPublicationYear: model?.firstPublicationYear
        )
        onGetBookInfo?(bookInfoModel)
    }
}
