//
//  Coordinator.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func toMain()
}
