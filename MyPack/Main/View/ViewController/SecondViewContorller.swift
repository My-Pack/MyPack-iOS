//
//  SecondViewContorller.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import PhotosUI
import SnapKit
import UIKit

// MARK: - 뷰컨트롤러 생성자

class SecondViewController: UIViewController {
    private let viewModel: SecondViewModel
    private var disposableBag = Set<AnyCancellable>()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Make it!"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    lazy var plusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        btn.tintColor = .white
        btn.addAction(UIAction(handler: { _ in
            self.requestPhotoLibraryAccess()
            var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            configuration.selectionLimit = 1
            configuration.filter = .images
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }), for: .touchUpInside)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 16
        return btn
    }()

    let seletedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.cornerRadius = 16
        return imageView
    }()

    init(viewModel: SecondViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor(rgb: 0x222222)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 뷰컨트롤러 라이프 사이클

extension SecondViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
        addUI()
        setLayout()
    }
}

// MARK: - 뷰모델 관련

private extension SecondViewController {
    func setBindings() {
        viewModel.$pickedImage.sink { img in
            self.seletedImage.image = img
        }.store(in: &disposableBag)

        viewModel.$isPicked.sink { picked in
            if picked { self.plusBtn.isHidden = true }
        }.store(in: &disposableBag)
    }
}

// MARK: - UI 관련

extension SecondViewController {
    func addUI() {
        view.addSubview(plusBtn)
        view.addSubview(titleLabel)
        view.addSubview(seletedImage)
    }

    func setLayout() {
        plusBtn.snp.makeConstraints { btn in
            btn.width.equalTo(280)
            btn.height.equalTo(400)
            btn.center.equalTo(self.view)
        }
        titleLabel.snp.makeConstraints { label in
            label.top.equalTo(view.safeAreaLayoutGuide)
            label.leading.equalTo(16)
        }
        seletedImage.snp.makeConstraints { img in
            img.width.equalTo(280)
            img.height.equalTo(400)
            img.center.equalTo(self.view)
        }
    }
}

extension SecondViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    guard let selectedImage = image as? UIImage else { return }
                    self.viewModel.setPickedImage(img: selectedImage)
                    self.viewModel.setIsPicked(bool: true)
                }
            }
        }
    }

    func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                print("User has granted access to photo library.")
            case .denied, .restricted:
                print("User has denied/restricted access to photo library.")
            case .notDetermined:
                print("User has not yet been asked to grant photo library access.")
            case .limited:
                print("User has granted limited access to photo library.")
            @unknown default:
                print("Unknown photo library access status.")
            }
        }
    }
}
