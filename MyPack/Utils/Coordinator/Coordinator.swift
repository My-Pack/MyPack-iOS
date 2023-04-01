//
//  Coordinator.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get }

    func start()
}
