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

    private lazy var boxView: BoxView = {
        let view = BoxView(frame: CGRect(x: 16, y: 148, width: 362, height: 540), radius: 10, color: UIColor.white)
        return view
    }()

    private lazy var logoView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 95, y: 204, width: 204, height: 204))
        view.image = UIImage(named: "imgmypack.png")!
        return view
    }()

    private lazy var logoLabel: LogoLabel = {
        let label = LogoLabel(text: "My Pack", font: UIFont(name: "PingFangSC-Semibold", size: 64)!, textColor: UIColor(rgb: 0x3A3A3A), shadow: true)
        return label
    }()

    private lazy var googleloginButton: LoginButton = {
        let button = LoginButton(title: "Google Login", frame: CGRect(x: 39, y: 529, width: 316, height: 60), action: UIAction(title: "title") { [weak self] _ in
            GIDSignIn.sharedInstance.signIn(withPresenting: self!) { result, _ in
                guard result != nil else { fatalError("Google Signin result is null") }
                guard result!.user.idToken != nil else { fatalError("idToken is null") }
                self?.loginViewModel.login(token: result!.user.idToken!.tokenString)
            }
        })
        button.setImage(UIImage(named: "googlelogo"), for: .normal)
        return button
    }()

    private lazy var appleloginButton: LoginButton = {
        let button = LoginButton(title: "Apple Login", frame: CGRect(x: 39, y: 605, width: 316, height: 60), action: UIAction(title: "title") { [weak self] _ in
//            self?.loginViewModel.login()
        })
        button.setImage(UIImage(named: "applelogo"), for: .normal)
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
        addUI()
    }
}

// MARK: - UI 관련

extension LoginViewController {
    func addUI() {
        view.addSubview(boxView)
        view.addSubview(logoView)
        view.addSubview(logoLabel)
        view.addSubview(googleloginButton)
        view.addSubview(appleloginButton)
    }
}
