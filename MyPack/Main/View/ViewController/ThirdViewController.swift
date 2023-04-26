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

    private lazy var backgroundView: UIButton = {
        let backgroundBtn = UIButton()
        backgroundBtn.setImage(UIImage(named: "backgroundImage.jpeg"), for: .normal)
        backgroundBtn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 197)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 197)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        backgroundBtn.layer.addSublayer(gradientLayer)
        return backgroundBtn
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

    private lazy var profileView: UIButton = {
        let profileBtn = UIButton()
        profileBtn.setImage(UIImage(named: "userprofile.png"), for: .normal)
        profileBtn.frame = CGRect(x: 142, y: 112, width: 110, height: 110)
        return profileBtn
    }()

    private lazy var followerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 280, y: 180, width: 120, height: 30))
        label.text = "팔로워 100"
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()

    private lazy var followingLabel: UILabel = {
        let followinglabel = UILabel(frame: CGRect(x: 280, y: 200, width: 120, height: 30))
        followinglabel.text = "팔로잉 100"
        followinglabel.font = UIFont.systemFont(ofSize: 14)
        followinglabel.sizeToFit()
        return followinglabel
    }()

    private lazy var tab1Button: UIButton = {
        let button = UIButton()
        button.setTitle("My Card", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 22, y: 80, width: 161, height: 25)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tab1ButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var tab2Button: UIButton = {
        let button = UIButton()
        button.setTitle("My Pack", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 210, y: 80, width: 161, height: 25)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tab2ButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var myCardView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 130, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        view.addSubview(myCard1)
        view.addSubview(myCard2)
        return view
    }()

    private lazy var myCard1: UIButton = {
        let myCard1Btn = UIButton()
        myCard1Btn.setImage(UIImage(named: "myCard.jpeg"), for: .normal)
        myCard1Btn.frame = CGRect(x: 8, y: 0, width: 185, height: 276)
        myCard1Btn.layer.cornerRadius = 10
        myCard1Btn.clipsToBounds = true
        return myCard1Btn
    }()

    private lazy var myCard2: UIButton = {
        let myCard2Btn = UIButton()
        myCard2Btn.setImage(UIImage(named: "myCard.jpeg"), for: .normal)
        myCard2Btn.frame = CGRect(x: 200, y: 0, width: 185, height: 276)
        myCard2Btn.layer.cornerRadius = 10
        myCard2Btn.clipsToBounds = true
        return myCard2Btn
    }()

    private lazy var myPackView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 130, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        view.addSubview(myPack1)
        view.addSubview(myPack2)
        return view
    }()

    private lazy var myPack1: UIButton = {
        let myPack1Btn = UIButton()
        myPack1Btn.setImage(UIImage(named: "myPack.jpeg"), for: .normal)
        myPack1Btn.frame = CGRect(x: 8, y: 0, width: 185, height: 276)
        myPack1Btn.layer.cornerRadius = 10
        myPack1Btn.clipsToBounds = true
        return myPack1Btn
    }()

    private lazy var myPack2: UIButton = {
        let myPack2Btn = UIButton()
        myPack2Btn.setImage(UIImage(named: "myPack.jpeg"), for: .normal)
        myPack2Btn.frame = CGRect(x: 200, y: 0, width: 185, height: 276)
        myPack2Btn.layer.cornerRadius = 10
        myPack2Btn.clipsToBounds = true
        return myPack2Btn
    }()

    private var scrollView: UIScrollView {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 178, width: view.frame.width, height: view.frame.height - 50))
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: view.frame.height * 2)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false

        // 각 탭에 해당하는 뷰를 스크롤 뷰에 추가합니다.
        scrollView.addSubview(myCardView)
        scrollView.addSubview(myPackView)
        scrollView.addSubview(tab1Button)
        scrollView.addSubview(tab2Button)

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
        myCardView.isHidden = false
        myPackView.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - UI 관련

private extension ThirdViewController {
    func addUI() {
        view.addSubview(scrollView)
        view.addSubview(backgroundView)
        view.addSubview(gradientCircleView)
        view.addSubview(profileView)
        view.addSubview(followerLabel)
        view.addSubview(followingLabel)
    }

    @objc func tab1ButtonTapped() {
        myCardView.isHidden = false
        myPackView.isHidden = true
        tab1Button.backgroundColor = UIColor.gray
        tab2Button.backgroundColor = UIColor.white
    }

    @objc func tab2ButtonTapped() {
        myCardView.isHidden = true
        myPackView.isHidden = false
        tab1Button.backgroundColor = UIColor.white
        tab2Button.backgroundColor = UIColor.gray
    }
}
