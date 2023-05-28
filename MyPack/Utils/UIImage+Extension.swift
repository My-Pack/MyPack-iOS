//
//  UIImage+Extension.swift
//  MyPack
//
//  Created by jito on 2023/05/29.
//

import AVFoundation
import UIKit

extension UIImage {
    func resizeToFill(to size: CGSize) -> UIImage? {
        let scale = max(size.width / self.size.width, size.height / self.size.height)
        let resizedSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)

        let renderer = UIGraphicsImageRenderer(size: resizedSize)
        var resizedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: resizedSize))
        }

        resizedImage = UIImage(cgImage: resizedImage.cgImage!, scale: 1.0, orientation: .downMirrored)

        let origin = CGPoint(x: (resizedSize.width - size.width) / 2, y: (resizedSize.height - size.height) / 2)
        let rect = CGRect(origin: origin, size: size)

        if let cgImage = resizedImage.cgImage?.cropping(to: rect) {
            let finalImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .upMirrored)
            return finalImage
        }

        return nil
    }
}
