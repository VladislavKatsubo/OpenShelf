//
//  BookShelfViewModel.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import Foundation

protocol BookShelfViewModelProtocol {
    var onStateChange: ((BookShelfResources.State) -> Void)? { get set }
    func launch()
}

final class BookShelfViewModel: BookShelfViewModelProtocol {

    typealias Constants = BookShelfResources.Constants.Mocks

    private let networkManager: NetworkManagerProtocol
    private let imageManager: ImageManagerProtocol

    var onStateChange: ((BookShelfResources.State) -> Void)?

    // MARK: - Init
    init(networkManager: NetworkManagerProtocol, imageManager: ImageManagerProtocol) {
        self.networkManager = networkManager
        self.imageManager = imageManager
    }

    // MARK: - Public methods
    func launch() {
        getProfileViewInfo()
        fetchBooksBySubject()
    }
}

private extension BookShelfViewModel {
    // MARK: - Private methods
    func fetchBooksBySubject() {
        guard let url = RequestConstructor.Endpoint.books(
            limit: Constants.booksResponseLimit,
            offset: Constants.startingRequestOffset
        ).url() else {
            return
        }

        networkManager.fetchData(url: url, expecting: APISubjectBooks.self) { [weak self] result in
            switch result {
            case .success(let result):
                let books = result.works
                self?.processBooksToCellModels(books)
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchRating(for key: String?, completion: @escaping (Double?, Int?) -> Void) {
        guard let key = key,
              let url = RequestConstructor.Endpoint.ratings(keyWithEndpoint: key).url() else {
            completion(nil, nil)
            return
        }

        networkManager.fetchData(url: url, expecting: APIBookRating.self) { result in

            switch result {
            case .success(let rating):
                completion(rating.summary?.average, rating.summary?.count)
            case .failure(let failure):
                print(failure)
                completion(nil, nil)
            }
        }
    }

    func processBooksToCellModels(_ books: [Book]) {
        let dispatchGroup = DispatchGroup()
        var cellModels: [BookShelfTableViewCell.Model] = []

        books.forEach { book in
            dispatchGroup.enter()

            fetchRating(for: book.key) { averageRating, ratingsCount in
                
                let cellModel = BookShelfTableViewCell.Model(
                    key: book.key,
                    title: book.title,
                    author: book.authors?.first?.name,
                    coverID: book.coverId,
                    firstPublicationYear: book.firstPublishYear,
                    averageRating: averageRating,
                    ratingsCount: ratingsCount
                )

                cellModels.append(cellModel)
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }

            self.onStateChange?(.onFetchBooks(cellModels, self.imageManager))
        }
    }

    func getProfileViewInfo() {
        onStateChange?(.onSetProfileView(Constants.profileViewMock))
    }
}
