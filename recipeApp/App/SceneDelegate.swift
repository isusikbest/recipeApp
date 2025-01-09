//
//  SceneDelegate.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 31/10/2024.
//

import UIKit
import Moya

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let screensFactory = ScreensFactory()
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController, screensFactory: screensFactory)
        appCoordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
}
