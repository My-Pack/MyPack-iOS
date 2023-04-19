//
//  ThirdViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController {
    private let viewModel: ThirdViewModel

    init(viewModel: ThirdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    private lazy var backgroundView: ImageView = {
        let view = ImageView(image: UIImage(named: "backgroundImage.jpeg")!, frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 197))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.addSublayer(gradientLayer)
        return view
    }()

    private lazy var gradientCircleView: UIView = {
        let circle = UIView()
        circle.frame = CGRect(x: 137, y: 107, width: 120, height: 120)
        circle.layer.cornerRadius = circle.frame.height / 2
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = circle.bounds
        gradientLayer.cornerRadius = circle.frame.height / 2
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(rgb: 0x31930F).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        circle.layer.insertSublayer(gradientLayer, at: 0)
        return circle
    }()

    private lazy var profileView: ImageView = {
        let view = ImageView(image: UIImage(named: "userprofile.png")!, frame: CGRect(x: 142, y: 112, width: 110, height: 110))
        return view
    }()

    private lazy var tab1Button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 22, y: 238, width: 161, height: 25)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tab1ButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var tab2Button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 210, y: 238, width: 161, height: 25)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tab2ButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var myCardView: UIView = {
        let view = UIView()
        view.frame(forAlignmentRect: CGRect(x: 0, y: 340, width: UIScreen.main.bounds.size.width, height: 100))
        view.backgroundColor = UIColor.red
        return view
    }()

    private lazy var myPackView: UIView = {
        let view = UIView()
        view.frame(forAlignmentRect: CGRect(x: 0, y: 340, width: UIScreen.main.bounds.size.width, height: 100))
        view.backgroundColor = UIColor.blue
        return view
    }()

    private var scrollView: UIScrollView {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 178, width: view.frame.width, height: view.frame.height - 50))
        scrollView.contentSize = CGSize(width: view.frame.width * 2, height: view.frame.height - 50)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false

        // 각 탭에 해당하는 뷰를 스크롤 뷰에 추가합니다.
        scrollView.addSubview(myCardView)
        scrollView.addSubview(myPackView)

        return scrollView
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 뷰컨트롤러 라이프 사이클

extension ThirdViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addUI()
    }
}

// MARK: - UI 관련

private extension ThirdViewController {
    func addUI() {
        view.addSubview(scrollView)
        view.addSubview(backgroundView)
        view.addSubview(gradientCircleView)
        view.addSubview(profileView)
        view.addSubview(tab1Button)
        view.addSubview(tab2Button)
    }

//    func scroll() {
//        // 스크롤 뷰를 구성합니다.
//        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height - 50))
//        scrollView.contentSize = CGSize(width: view.frame.width * 2, height: view.frame.height - 50)
//        scrollView.isPagingEnabled = true
//        scrollView.showsHorizontalScrollIndicator = false
//
//        // 각 탭에 해당하는 뷰를 스크롤 뷰에 추가합니다.
//        scrollView.addSubview(myCardView)
//        scrollView.addSubview(myPackView)
//    }

    @objc func tab1ButtonTapped() {
        tabBarController?.selectedIndex = 0
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    @objc func tab2ButtonTapped() {
        tabBarController?.selectedIndex = 1
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
//    func updateUserProfile(userName: String) {
//        text.text = userName
//    }
}
