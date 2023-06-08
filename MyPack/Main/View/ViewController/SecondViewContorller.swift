//
//  SecondViewContorller.swift
//  MyPack
//
//  Created by 김하은 on 2023/03/29.
//

import Combine
import MyPackNetwork
import PhotosUI
import SnapKit
import UIKit

// MARK: - 뷰컨트롤러 생성자

class SecondViewController: UIViewController {
    private let viewModel: SecondViewModel
    private var disposableBag = Set<AnyCancellable>()
    private let styleSize: CGFloat = 46

    lazy var styles: [UIButton] = {
        var styles: [UIButton] = []
        styles.append(contentsOf: [
            StyleButton(color: UIColor(rgb: 0xC501E2), viewModel: viewModel),
            StyleButton(color: UIColor(rgb: 0x2EF8A0), viewModel: viewModel),
            StyleButton(color: UIColor(rgb: 0xE7C500), viewModel: viewModel),
            StyleButton(color: UIColor(rgb: 0xF82D97), viewModel: viewModel),
            StyleButton(color: UIColor(rgb: 0xE830CE), viewModel: viewModel)
        ])
        return styles
    }()

    let styleScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        scrollView.isHidden = true
        return scrollView
    }()

    lazy var makeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Make it!", for: .normal)
        btn.addAction(UIAction(handler: { [weak self] _ in
            guard self?.viewModel.isValidCardData() ?? false else { return }
            print(UserDefaults.standard.string(forKey: "UserToken") ?? "")
            Task {
                do {
                    let imageId = try await self?.viewModel.uploadImage(
                        token: UserDefaults.standard.string(forKey: "UserToken") ?? "",
                        image: (self?.viewModel.pickedImage!)!,
                        fileName: ""
                    )
                    if let imageId = imageId {
                        let result = try await self?.viewModel.uploadCard(token: UserDefaults.standard.string(forKey: "UserToken") ?? "", imageId: imageId)
                        print(result as Any)
                        self?.viewModel.mainTabBarCoordinator?.navigationController?.popViewController(animated: true)
                    }
                } catch {
                    print("Failed to upload card: \(error)")
                }
            }
        }), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return btn
    }()

    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        btn.tintColor = .white
        btn.addAction(UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        return btn
    }()

    lazy var cardTitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = "타이틀을 입력해주세요."
        textField.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textField.textColor = .darkGray
        textField.setPlaceholder(color: .gray)
        textField.addAction(UIAction(handler: { _ in
            self.viewModel.setCardTitle(text: textField.text ?? "")
        }), for: .editingChanged)
        return textField
    }()

    lazy var cardContent: UITextField = {
        let textField = UITextField()
        textField.placeholder = "본문을 입력해주세요."
        textField.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textField.textColor = .darkGray
        textField.setPlaceholder(color: .gray)
        textField.addAction(UIAction(handler: { _ in
            self.viewModel.setCardContent(text: textField.text ?? "")
        }), for: .editingChanged)
        return textField
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

    let containerView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.isUserInteractionEnabled = true
        return view
    }()

    lazy var selectedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backFlipView))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 16
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(frontFlipView))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
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
        scrollSetting()
    }
}

// MARK: - 뷰모델 관련

private extension SecondViewController {
    func setBindings() {
        viewModel.$pickedImage.sink { img in
            self.selectedImage.image = img
        }.store(in: &disposableBag)

        viewModel.$isPicked.sink { picked in
            if picked {
                self.plusBtn.isHidden = true
                self.containerView.isHidden = false
                self.styleScrollView.isHidden = false
            }
        }.store(in: &disposableBag)

        viewModel.$cardStyle.sink { [self] color in
            self.selectedImage.layer.borderColor = color.cgColor
            self.backView.layer.borderColor = color.cgColor
            self.containerView.layer.shadowColor = color.cgColor
            self.containerView.layer.shadowRadius = 16
            self.containerView.layer.shadowOpacity = 0.6

            viewModel.cardColor = color.toHexString
        }.store(in: &disposableBag)

        viewModel.$cardTitle.sink { title in
            self.cardTitle.text = title
        }.store(in: &disposableBag)

        viewModel.$cardContent.sink { content in
            self.cardContent.text = content
        }.store(in: &disposableBag)
    }
}

// MARK: - UI 관련

extension SecondViewController {
    func addUI() {
        view.addSubview(plusBtn)
        view.addSubview(makeBtn)
        view.addSubview(backBtn)
        view.addSubview(styleScrollView)
        view.addSubview(containerView)
        containerView.addSubview(backView)
        containerView.addSubview(selectedImage)
        backView.addSubview(cardTitle)
        backView.addSubview(cardContent)
    }

    func setLayout() {
        styleScrollView.snp.makeConstraints { scroll in
            scroll.centerX.equalTo(self.view)
            scroll.leading.equalTo(0)
            scroll.trailing.equalTo(0)
            scroll.bottom.equalTo(self.view).offset(-100)
            scroll.height.equalTo(styleSize)
        }
        plusBtn.snp.makeConstraints { btn in
            btn.width.equalTo(280)
            btn.height.equalTo(400)
            btn.center.equalTo(self.view)
        }
        makeBtn.snp.makeConstraints { label in
            label.top.equalTo(view.safeAreaLayoutGuide)
            label.trailing.equalTo(-16)
        }
        containerView.snp.makeConstraints { view in
            view.width.equalTo(280)
            view.height.equalTo(400)
            view.center.equalTo(self.view)
        }
        selectedImage.snp.makeConstraints { img in
            img.width.equalTo(280)
            img.height.equalTo(400)
            img.center.equalToSuperview()
        }
        backView.snp.makeConstraints { view in
            view.width.equalTo(280)
            view.height.equalTo(400)
            view.center.equalToSuperview()
        }
        backBtn.snp.makeConstraints { btn in
            btn.top.equalTo(view.safeAreaLayoutGuide)
            btn.leading.equalTo(16)
        }
        cardTitle.snp.makeConstraints { label in
            label.top.equalToSuperview().offset(16)
            label.leading.equalToSuperview().offset(16)
        }
        cardContent.snp.makeConstraints { label in
            label.top.equalTo(cardTitle.snp.bottom).offset(16)
            label.leading.equalToSuperview().offset(16)
        }
    }

    func scrollSetting() {
        let stackView = UIStackView(arrangedSubviews: styles)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fillEqually

        styleScrollView.addSubview(stackView)

        let guide = styleScrollView.contentLayoutGuide
        stackView.snp.makeConstraints { view in
            view.leading.equalTo(guide)
            view.trailing.equalTo(guide)
            view.top.equalTo(guide)
            view.bottom.equalTo(guide)
            view.height.equalTo(styleSize)
        }

        for style in styles {
            style.snp.makeConstraints { style in
                style.width.equalTo(styleSize)
            }
        }
    }
}

// MARK: - @Objc

extension SecondViewController {
    @objc func backFlipView() {
        UIView.transition(from: selectedImage, to: backView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
    }

    @objc func frontFlipView() {
        UIView.transition(from: backView, to: selectedImage, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
    }
}

// MARK: - PHPickerViewControllerDelegate

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
