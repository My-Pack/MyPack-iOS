//
//  CardCell.swift
//  MyPack
//
//  Created by 김하은 on 2023/06/07.
//

import Foundation
import UIKit

class CardCell: UICollectionViewCell {
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // 이미지 뷰를 셀에 추가합니다.
        addSubview(cardImageView)

        // 이미지 뷰의 오토레이아웃을 설정합니다.
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(with card: Card) {
        // 셀에 표시할 이미지를 설정합니다.
        cardImageView.image = card.cardImage
    }
}
