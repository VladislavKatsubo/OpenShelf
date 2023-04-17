//
//  BookShelfFactory.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import UIKit

final class BookShelfFactory {
    func createController() -> UIViewController {
        let session = URLSession(configuration: .default)
        let networkManager = NetworkManager(session: session)
        let imageManager = ImageManager(networkManager: networkManager)
        let viewModel = BookShelfViewModel(networkManager: networkManager, imageManager: imageManager)
        let viewController = BookShelfViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}
