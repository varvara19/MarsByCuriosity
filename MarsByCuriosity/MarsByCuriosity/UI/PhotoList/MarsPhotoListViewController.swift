//
//  MarsPhotoListViewController.swift
//  MarsByCuriosity
//
//

import UIKit

final class MarsPhotoListViewController: CoreViewController {
    private let viewModel: MarsPhotoListViewModel
    
    private lazy var collectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 109.adapted, height: 109.adapted)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(MarsPhotoCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 16.0, left: 8.0, bottom: 16.0, right: 8.0)
        return collectionView
    }()
    
    init(viewModel: MarsPhotoListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupNavBar()
        addBackSwipe()
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func addSubviews() {
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onBackButton))
        
        navigationItem.titleView = UINavigationItem.setTitle(title: viewModel.title, subtitle: viewModel.displayableDate, type: .boldTitle)
    }
    
    private func addBackSwipe() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc private func onBackButton() {
        navigationController?.popViewController(animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}

// MARK: - UICollectionViewDataSource
extension MarsPhotoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MarsPhotoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.updateWith(entity: viewModel.photos[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            indexPath.row == viewModel.photos.count - 1,
            !viewModel.isLoadingNextPage
        else { return }
        
        viewModel.loadNextPage()
    }
}

// MARK: - UICollectionViewDelegate
extension MarsPhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MarsPhotoListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer else { return true }
        
        onBackButton()
        return false
    }
}

// MARK: - MarsPhotoListViewModelDelegate
extension MarsPhotoListViewController: MarsPhotoListViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
