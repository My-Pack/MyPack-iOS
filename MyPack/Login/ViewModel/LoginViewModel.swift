//
//  LoginViewModel.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import Foundation
import UIKit

class LoginViewModel {
    private let loginService: LoginService
    weak var loginCoordinator: LoginCoordinator?

    init(loginService: LoginService, loginCoordinator: LoginCoordinator) {
        self.loginCoordinator = loginCoordinator
        self.loginService = loginService
    }

    private func fetchUserName(token: String) async -> String? {
        do {
            let loginToken = try await loginService.login(token: token)

            UserDefaults.standard.set(loginToken?.accessToken, forKey: "UserToken")
            return "name"
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    func login(token: String) {
        Task {
            if let userName = await fetchUserName(token: token) {
                await loginCoordinator?.didLoginSuccessfully(userName: userName)
            }
        }
    }
    // MARK: - 그라데이션 색상

    func gradientColor() -> UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(rgb: 0x000000).cgColor, UIColor(rgb: 0x434343).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = UIScreen.main.bounds

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return UIColor(patternImage: image!)
    }
}
