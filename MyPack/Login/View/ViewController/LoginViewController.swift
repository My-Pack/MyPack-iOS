//
//  LoginViewController.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import UIKit

// MARK: - 뷰컨트롤러 생성자

class LoginViewController: UIViewController {
    var loginViewModel: LoginViewModel
    var boxViewModel: BoxViewModel = .init()

    private lazy var boxView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: boxViewModel.size))
        view.backgroundColor = boxViewModel.backgroundColor
        view.layer.cornerRadius = boxViewModel.cornerRadius
        return view
    }()

    private lazy var logoView: ImageView = {
        let view = ImageView(image: UIImage(named: "imgmypack.png")!, frame: CGRect(x: 95, y: 204, width: 204, height: 184))
        return view
    }()

    private lazy var logoShadowView: ImageView = {
        let view = ImageView(image: UIImage(named: "shadowmypack.png")!, frame: CGRect(x: 108, y: 340, width: 180, height: 90))
        return view
    }()

    private lazy var logoLabel: LogoLabel = {
        let label = LogoLabel(text: "My Pack", font: UIFont(name: "PingFangSC-Semibold", size: 64)!, textColor: UIColor(rgb: 0x3A3A3A), shadow: true)
        return label
    }()

    private lazy var googleloginButton: LoginButton = {
        let button = LoginButton(title: "Google Login", frame: CGRect(x: 39, y: 529, width: 316, height: 60), action: UIAction(title: "title") { [weak self] _ in
            self?.loginViewModel.login()
        })
        button.setImage(UIImage(named: "googlelogo"), for: .normal)
        return button
    }()

    private lazy var appleloginButton: LoginButton = {
        let button = LoginButton(title: "Apple Login", frame: CGRect(x: 39, y: 605, width: 316, height: 60), action: UIAction(title: "title") { [weak self] _ in
            self?.loginViewModel.login()
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
        view.backgroundColor = loginViewModel.gradientColor()
        addUI()
    }
}

// MARK: - UI 관련

extension LoginViewController {
    func addUI() {
        // 맨 앞으로 보내기
        view.addSubview(logoView)
        view.bringSubviewToFront(logoView)
        view.addSubview(logoShadowView)
        view.bringSubviewToFront(logoShadowView)
        view.addSubview(logoLabel)
        view.bringSubviewToFront(logoLabel)
        view.addSubview(googleloginButton)
        view.addSubview(appleloginButton)
        view.addSubview(boxView)
        boxView.center = view.center
        view.sendSubviewToBack(boxView)
    }
}
