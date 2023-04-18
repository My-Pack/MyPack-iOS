//
//  LoginViewModel.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import Foundation
import UIKit

class LoginViewModel {
    private let loginService: LoginServiceProtocol
    weak var loginCoordinator: LoginCoordinatorProtocol?

    init(loginService: LoginServiceProtocol, loginCoordinator: LoginCoordinatorProtocol) {
        self.loginCoordinator = loginCoordinator
        self.loginService = loginService
    }

    private func fetchUserName() async -> String? {
        do {
            let userModel = try await loginService.login()
            return userModel?.name
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    func login() {
        Task {
            if let userName = await fetchUserName() {
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

// MARK: - 그라데이션 색상

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}
