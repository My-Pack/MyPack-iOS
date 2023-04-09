//
//  SceneDelegate.swift
//  MyPack
//
//  Created by jito on 2023/03/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var loginCoordinator: LoginCoordinatorProtocol?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // UIWindowScene에서 window 인스턴스 생성
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController()
        loginCoordinator = LoginCoordinatorImpl(navigationController: navigationController)
        loginCoordinator?.didLoginSuccessfully(userName: "jito")

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
