//
//  LoginViewController.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import GoogleSignIn
import UIKit

// MARK: - 뷰컨트롤러 생성자

class LoginViewController: UIViewController {
    var loginViewModel: LoginViewModel
    private lazy var loginButton: LoginButton = {
        let button = LoginButton(title: "Login", frame: CGRect(x: 100, y: 50, width: 100, height: 100), action: UIAction(title: "title") { [weak self] _ in
//            self?.loginViewModel.login()
            GIDSignIn.sharedInstance.signIn(withPresenting: self!) { result, _ in
                print(result?.user.idToken?.tokenString)
            }
        })
        return button
    }()

    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 뷰컨트롤러 생성자

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addUI()
    }
}

// MARK: - UI 관련

extension LoginViewController {
    func addUI() {
        view.addSubview(loginButton)
    }
}
