//
//  FirstViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import MyPackAnimation
import SnapKit
import UIKit

// MARK: - 뷰컨트롤러 생성자

class FirstViewController: UIViewController {
    private let viewModel: FirstViewModel
    private var disposableBag = Set<AnyCancellable>()
    private var cardDeck: CardDeck = .init()
    private var searchBtn: SearchBtn
    private var emitterAnimators = [EmitterAnimator]()

    init(viewModel: FirstViewModel) {
        self.viewModel = viewModel
        self.searchBtn = SearchBtn(viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = UIColor(rgb: 0x222222)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 뷰컨트롤러 라이프 사이클

extension FirstViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
        addUI()
        setLayout()
        setUpEmitterLayer()
    }
}

// MARK: - 뷰모델 관련

private extension FirstViewController {
    func setBindings() {
        viewModel.$userName.sink { userName in
            print("user: \(userName)")
            self.updateUser(userName: userName)
        }.store(in: &disposableBag)
    }
}

// MARK: - UI 관련

private extension FirstViewController {
    func addUI() {
        view.addSubview(cardDeck)
        view.addSubview(searchBtn)
    }

    func setLayout() {
        cardDeck.snp.makeConstraints { deck in
            deck.width.equalTo(UIScreen.main.bounds.width)
            deck.height.equalTo(UIScreen.main.bounds.height)
            deck.centerX.equalTo(view)
            deck.centerY.equalTo(view)
        }
        searchBtn.snp.makeConstraints { btn in
            btn.width.equalTo(30)
            btn.height.equalTo(30)
            btn.top.equalTo(view.safeAreaLayoutGuide)
            btn.trailing.equalTo(-16)
        }
    }

    func updateUser(userName _: String) {
        // user data UI에 업데이트하기
    }

    func setUpEmitterLayer() {
        for i in cardDeck.cardDeck {
            let images = i.effect?.map { UIImage(named: $0.image) } ?? []
            let emitterAnimator = EmitterAnimator(view: i, viewController: self, image: images)
            let tapGestureRecognizer = UITapGestureRecognizer(target: emitterAnimator, action: #selector(EmitterAnimator.imageViewTapped))
            i.addGestureRecognizer(tapGestureRecognizer)
            emitterAnimators.append(emitterAnimator)
        }
    }
}
