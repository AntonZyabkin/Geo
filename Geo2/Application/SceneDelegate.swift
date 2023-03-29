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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainViewController = MainViewController()
        let mainViewModel = MainViewModel()
        let window = UIWindow(windowScene: windowScene)

        mainViewController.viewModel = mainViewModel
        
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
