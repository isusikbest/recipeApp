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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let factory = ScreensFactory()
        let categoriesScreen = factory.createRecipeScreen()
       
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: categoriesScreen)
    }
}
