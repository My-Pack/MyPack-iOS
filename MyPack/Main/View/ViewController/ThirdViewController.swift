//
//  ThirdViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController, UICollectionViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        backgroundBtn.layer.addSublayer(gradientLayer)
        backgroundBtn.isUserInteractionEnabled = false
        return backgroundBtn
    }()

    private lazy var gradientCircleView: UIView = {
        let circle = UIView()
        circle.frame = CGRect(x: 50, y: 107, width: 120, height: 120)
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
        profileBtn.frame = CGRect(x: 55, y: 112, width: 110, height: 110)
        profileBtn.isUserInteractionEnabled = false
        return profileBtn
    }()

    private lazy var followerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 204, y: 134, width: 120, height: 30))
        label.text = "팔로워 100"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()

    private lazy var followingLabel: UILabel = {
        let followinglabel = UILabel(frame: CGRect(x: 204, y: 152, width: 120, height: 30))
        followinglabel.text = "팔로잉 100"
        followinglabel.textColor = .white
        followinglabel.font = UIFont.systemFont(ofSize: 14)
        followinglabel.sizeToFit()
        return followinglabel
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 편집", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 198, y: 177, width: 161, height: 25)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var tab1Button: UIButton = {
        let button = UIButton()
        button.setTitle("My Card", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 22, y: 240, width: 161, height: 25)
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
        button.frame = CGRect(x: 210, y: 240, width: 161, height: 25)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tab2ButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var myCardView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

        let columnCount = 2
        let itemWidth: CGFloat = 185
        let itemHeight: CGFloat = 276
        let horizontalSpacing: CGFloat = 10
        let verticalSpacing: CGFloat = 10

        var currentRow = 0
        var currentColumn = 0

        for _ in 0 ..< dataCount {
            let x = CGFloat(currentColumn) * (itemWidth + horizontalSpacing)
            let y = CGFloat(currentRow) * (itemHeight + verticalSpacing)

            let cardButton = UIButton()
            cardButton.setImage(UIImage(named: "myCard.jpeg"), for: .normal)
            cardButton.frame = CGRect(x: x, y: y, width: itemWidth, height: itemHeight)
            cardButton.layer.cornerRadius = 10
            cardButton.clipsToBounds = true

            view.addSubview(cardButton)

            currentColumn += 1
            if currentColumn == columnCount {
                currentColumn = 0
                currentRow += 1
            }
        }

        let rowCount = Int(ceil(Double(dataCount) / Double(columnCount)))
        let totalWidth = CGFloat(columnCount) * itemWidth + CGFloat(columnCount - 1) * horizontalSpacing
        let totalHeight = CGFloat(rowCount) * itemHeight + CGFloat(rowCount - 1) * verticalSpacing
        view.frame.size = CGSize(width: totalWidth, height: totalHeight)

        return view
    }()

    private var dataCount: Int = 8 // 데이터 개수에 따라 동적으로 설정해주세요

    private lazy var myPackView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        view.addSubview(myPack1)
        return view
    }()

    private lazy var myPack1: UILabel = {
        let myPackLabel = UILabel()
        myPackLabel.text = "준비중..."
        myPackLabel.textColor = .white
        myPackLabel.textAlignment = .center // 중앙 정렬
        myPackLabel.frame = CGRect(x: 0, y: 30, width: UIScreen.main.bounds.size.width, height: 30)
        return myPackLabel
    }()

    private var scrollView: UIScrollView {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 280, width: view.frame.width, height: view.frame.height - 50))
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: view.frame.height * 2)
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
        myCardView.isHidden = false
        myPackView.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - UI 관련

private extension ThirdViewController {
    func addUI() {
        view.backgroundColor = .black
        view.addSubview(tab1Button)
        view.addSubview(tab2Button)
        view.addSubview(scrollView)
        view.addSubview(backgroundView)
        view.addSubview(gradientCircleView)
        view.addSubview(profileView)
        view.addSubview(followerLabel)
        view.addSubview(followingLabel)
        view.addSubview(editButton)
    }

    @objc func editButtonTapped() {
        let bottomModalView = BottomModalView()
        bottomModalView.profileImageSelected = { [weak self] image in
            // Update profile image logic
            self?.profileView.setImage(image, for: .normal)
        }
        bottomModalView.backgroundImageSelected = { [weak self] image in
            // Update background image logic
            self?.backgroundView.setImage(image, for: .normal)
        }

        let bottomModalViewController = UIViewController()
        bottomModalViewController.view.addSubview(bottomModalView)
        bottomModalView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bottomModalView.leadingAnchor.constraint(equalTo: bottomModalViewController.view.leadingAnchor),
            bottomModalView.trailingAnchor.constraint(equalTo: bottomModalViewController.view.trailingAnchor),
            bottomModalView.bottomAnchor.constraint(equalTo: bottomModalViewController.view.bottomAnchor),
            bottomModalView.heightAnchor.constraint(equalToConstant: 150)
        ])

        present(bottomModalViewController, animated: true, completion: nil)
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
