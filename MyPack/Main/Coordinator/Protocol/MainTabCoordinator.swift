//
//  MainTabCoordinatorProtocol.swift
//  MyPack
//
//  Created by jito on 2023/04/02.
//

import UIKit

protocol MainTabBarCoordinator: Coordinator {
    func start(userName: String)
    func toSearchView()
    func toSecondView(vc: UIViewController)
}
