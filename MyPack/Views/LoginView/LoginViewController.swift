//
//  LoginViewController.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import UIKit

class LoginViewController: UIViewController {
    var loginViewModel: LoginViewModel?
    private var loginButton: LoginButton?

    init(loginViewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.loginViewModel = loginViewModel
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setUI()
    }

    func setUI() {
        loginButton = LoginButton(title: "Login", frame: CGRect(x: 100, y: 50, width: 100, height: 100), action: UIAction(title: "title") { _ in
            self.loginViewModel!.login()
        })
        view.addSubview(loginButton!)
    }
}
