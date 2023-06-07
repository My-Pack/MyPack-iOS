//
//  CardCellModel.swift
//  MyPack
//
//  Created by 김하은 on 2023/06/06.
//

import Foundation
import UIKit

class CardCellModel: UITableViewCell {
    // 셀의 구성 요소들
    // 예시: UIImageView, UILabel 등

    func configure(with _: Card) {
        let myCardBtn = UIButton()
        myCardBtn.setImage(UIImage(named: "myCard.jpeg"), for: .normal)
//        myCardBtn.frame = CGRect(x: 200, y: myCard2.frame.maxY + 10, width: 185, height: 276)
        myCardBtn.frame = CGRect(x: 0, y: 0, width: 185, height: 276)
        myCardBtn.layer.cornerRadius = 10
        myCardBtn.clipsToBounds = true
    }
}
