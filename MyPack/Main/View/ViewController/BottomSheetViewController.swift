//
//  BottomSheetViewController.swift
//  MyPack
//
//  Created by 김하은 on 2023/05/17.
//

import Foundation
import UIKit

class BottomSheetViewController: UIView {
    private var viewModel: BottomSheetViewModel
    private var initialY: CGFloat = 0.0

    var profiles: [ProfileModel] = []
    private weak var parentView: UIView?

    func setParentView(_ view: UIView) {
        parentView = view
    }

    // 리스트 뷰
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 16.0
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return tableView
    }()

    // ViewModel을 주입받는 초기화 메서드
    init(viewModel: BottomSheetViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGesture)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self

        addSubview(tableView)

        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")

        profiles = fetchProfiles()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

        addGestureRecognizer(tapGesture)
    }

    private func fetchProfiles() -> [ProfileModel] {
        return []
    }

    @objc private func handleTap(_: UITapGestureRecognizer) {
        removeFromSuperview()
    }
}

// MARK: - UITableViewDataSource

extension BottomSheetViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return profiles.count + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)

        if indexPath.row == 0 {
            cell.textLabel?.text = "프로필 사진 보기"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "프로필 사진 편집"
        } else {
            let profile = profiles[indexPath.row - 2]
            cell.textLabel?.text = profile.name
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension BottomSheetViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("프로필 사진 보기")
        } else if indexPath.row == 1 {
            print("프로필 사진 편집")
        } else {
            let selectedProfile = profiles[indexPath.row - 2]
            print("프로필 선택: \(selectedProfile.name)")
        }

        removeFromSuperview()
    }
}

// MARK: - Pan Gesture Handling

extension BottomSheetViewController {
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let superview = superview else { return }

        let translation = gesture.translation(in: superview)

        switch gesture.state {
        case .began:
            initialY = frame.origin.y
        case .changed:
            let newY = initialY + translation.y
            frame.origin.y = max(newY, superview.frame.height - frame.height)
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: superview)
            let shouldClose = velocity.y > 0

            if shouldClose {
                removeFromSuperview()
            } else {
                frame.origin.y = superview.frame.height - frame.height
            }
        default:
            break
        }

        gesture.setTranslation(.zero, in: superview)
    }
}
