//
//  SceneDelegate.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainViewController = MainViewController()
        let mainViewModel = MainViewModel(
            dataService: MockService(),
            view: mainViewController,
            locationService: LocationService()
        )
        let window = UIWindow(windowScene: windowScene)
        mainViewController.viewModel = mainViewModel
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

