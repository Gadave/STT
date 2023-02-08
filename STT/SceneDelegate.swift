//
//  SceneDelegate.swift
//  STT
//
//  Created by Георгий Давыденко on 08.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let initialScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: initialScene)
        let vc = MainViewController()
        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }


}

