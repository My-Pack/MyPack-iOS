//
//  CardDataSource.swift
//  MyPack
//
//  Created by 김하은 on 2023/06/06.
//

import Foundation
import UIKit

class CardDataSource: NSObject, UICollectionViewDataSource {
    var myCardData: [Card] = []

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return myCardData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCardCell", for: indexPath) as? CardCell else {
            fatalError("Failed to dequeue CardCell")
        }

        let card = myCardData[indexPath.item]
        cell.configure(with: card)

        return cell
    }
}
