//
//  SceneDelegate.swift
//  OpenShelf
//
//  Created by Vlad Katsubo on 14.04.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let viewController = BookShelfFactory().createController()

        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        self.window = window
    }
}

