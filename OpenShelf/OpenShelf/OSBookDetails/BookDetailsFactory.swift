//
//  BookDetailsFactory.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 15.04.23.
//

import UIKit

final class BookDetailsFactory {
    func createController(with model: BookShelfTableViewCell.Model) -> UIViewController {
        let session = URLSession(configuration: .default)
        let networkManager = NetworkManager(session: session)
        let imageManager = ImageManager(networkManager: networkManager)
        let viewModel = BookDetailsViewModel(model: model, networkManager: networkManager, imageManager: imageManager)
        let viewController = BookDetailsViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}
