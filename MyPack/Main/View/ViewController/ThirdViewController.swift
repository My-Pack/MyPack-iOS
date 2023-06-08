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

    private lazy var myCardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 50), collectionViewLayout: layout)
        collectionView.dataSource = myCardDataSource
        collectionView.delegate = self
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "MyCardCell")
        collectionView.backgroundColor = .black
        return collectionView
    }()

    private let myCardDataSource = CardDataSource()

    private func setupMyCards() {
        let myCardData = fetchMyCardData()
        var infiniteMyCardData: [Card] = []
        let numberOfLoops = 2
        for _ in 0 ..< numberOfLoops {
            infiniteMyCardData += myCardData
        }

        myCardDataSource.myCardData = infiniteMyCardData
        myCardCollectionView.reloadData()
    }

    func fetchMyCardData() -> [Card] {
        let card1 = Card(cardID: 1, cardImage: UIImage(named: "myCard.png")!, cardTitle: "Card 1", cardDescription: "This is Card 1.")
        let card2 = Card(cardID: 2, cardImage: UIImage(named: "myCard.png")!, cardTitle: "Card 2", cardDescription: "This is Card 2.")

        return [card1, card2]
    }

    private func updateCollectionViewHeight() {
        let contentHeight = myCardCollectionView.contentSize.height
        myCardCollectionView.frame.size.height = contentHeight
        scrollView.contentSize.height = contentHeight + 20 // myCard가 시작되는 위치
    }

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
        scrollView.addSubview(myCardCollectionView)
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
        myCardCollectionView.isHidden = false
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
//        let bottomSheetView = BottomSheetView(frame: CGRect(x: 0, y: view.bounds.height - 180, width: view.bounds.width, height: 180))
        let bottomSheetView = BottomSheetView()
        bottomSheetView.profileImageSelected = { [weak self] image in
            // Update profile image logic
            self?.profileView.setImage(image, for: .normal)
        }
        bottomSheetView.backgroundImageSelected = { [weak self] image in
            // Update background image logic
            self?.backgroundView.setImage(image, for: .normal)
        }

        let bottomSheetViewController = UIViewController()
        bottomSheetViewController.view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: bottomSheetViewController.view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: bottomSheetViewController.view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: bottomSheetViewController.view.bottomAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 150)
        ])

        present(bottomSheetViewController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCardCell", for: indexPath) as? CardCell else {
            return UICollectionViewCell()
        }

        let card = myCardDataSource.myCardData[indexPath.item]
        cell.configure(with: card)

        return cell
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return myCardDataSource.myCardData.count
    }

    @objc func tab1ButtonTapped() {
        myCardCollectionView.isHidden = false
        myPackView.isHidden = true
        tab1Button.backgroundColor = UIColor.gray
        tab2Button.backgroundColor = UIColor.white
    }

    @objc func tab2ButtonTapped() {
        myCardCollectionView.isHidden = true
        myPackView.isHidden = false
        tab1Button.backgroundColor = UIColor.white
        tab2Button.backgroundColor = UIColor.gray
    }
}
