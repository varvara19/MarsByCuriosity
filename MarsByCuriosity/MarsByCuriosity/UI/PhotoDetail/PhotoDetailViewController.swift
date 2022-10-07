//
//  PhotoDetailViewController.swift
//  MarsByCuriosity
//
//

import UIKit

final class PhotoDetailViewController: CoreViewController {
    override var textColor: UIColor { .appWhite }
    override var backgroundColor: UIColor { .appBlack }
    
    private let marsPhotoImageView = UIImageView()
    private let viewModel: PhotoDetailViewModel
    
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupNavBar()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .darkContent
    }
    
    override func addSubviews() {
        view.addSubview(marsPhotoImageView)
    }
    
    override func setupConstraints() {
        marsPhotoImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func loadImage() {
        if let image = viewModel.image {
            marsPhotoImageView.image = image
        } else if let imageUrlString = viewModel.urlString {
            AppHUD.show()
            marsPhotoImageView.downloaded(from: imageUrlString) { image in
                self.viewModel.image = image
                AppHUD.hide()
            }
        }
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onBackButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(didClickDownloadButton))
        
        DispatchQueue.main.async {
            self.navigationItem.titleView = UINavigationItem.setTitle(title: self.viewModel.title, subtitle: self.viewModel.subtitle, type: .boldDescription)
        }
    }
    
    private func setupImageView() {
        marsPhotoImageView.layer.masksToBounds = true
        marsPhotoImageView.layer.cornerRadius = AppConstants.cornerRadius
        marsPhotoImageView.backgroundColor = .cellBackgroundColor
    }
    
    private func addBackSwipe() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc private func onBackButton() {
        navigationController?.popViewController(animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc private func didClickDownloadButton() {
        guard let selectedImage = marsPhotoImageView.image else { return }
        
        AppHUD.show()
        
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        AppHUD.hide()
        
        if let error = error {
            AlertManager.showError(error.localizedDescription)
        } else {
            AlertManager.showAlert(title: LS("SUCCESS.TITLE"), message: LS("SUCCESS.DOWNLOAD.MESSAGE"))
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PhotoDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer else { return true }
        
        onBackButton()
        return false
    }
}
