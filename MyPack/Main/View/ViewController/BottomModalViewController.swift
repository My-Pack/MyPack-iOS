//
//  BottomSheetViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/05/17.
//

import Foundation
import UIKit

class BottomModalView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var profileImageSelected: ((UIImage) -> Void)?
    var backgroundImageSelected: ((UIImage) -> Void)?

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 사진 변경", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backgroundButton: UIButton = {
        let button = UIButton()
        button.setTitle("배경 사진 변경", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(backgroundButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        addSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomModalView {
    func addSubviews() {
        addSubview(profileButton)
        addSubview(separatorView)
        addSubview(backgroundButton)

        profileButton.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        backgroundButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileButton.heightAnchor.constraint(equalToConstant: 30),

            separatorView.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 16),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),

            backgroundButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16),
            backgroundButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backgroundButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backgroundButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension BottomModalView {
    @objc func profileButtonTapped() {
        print("tap")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true

        var parentViewController: UIViewController?
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let viewController = responder as? UIViewController {
                parentViewController = viewController
                break
            }
        }

        parentViewController?.present(imagePicker, animated: true, completion: nil)
    }

    @objc func backgroundButtonTapped() {
        print("tap")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true

        var parentViewController: UIViewController?
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let viewController = responder as? UIViewController {
                parentViewController = viewController
                break
            }
        }

        parentViewController?.present(imagePicker, animated: true, completion: nil)
    }
}
