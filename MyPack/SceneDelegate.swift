//
//  SceneDelegate.swift
//  MyPack
//
//  Created by jito on 2023/03/16.
//

import GoogleSignIn
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var loginCoordinator: LoginCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // UIWindowScene에서 window 인스턴스 생성
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let config = GIDConfiguration(clientID: "359063232439-c70rvi9jpapuurtmohl8ila077omosk9.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.configuration = config

        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        loginCoordinator = LoginCoordinatorImpl(navigationController: navigationController)
        loginCoordinator?.start()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
