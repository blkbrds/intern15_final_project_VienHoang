//
//  HomeViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupData()
        setupUI()
    }

    private func setupUI() {
        let nib = UINib(nibName: Identifier.collectionViewCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Identifier.collectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupData() {
        loadApi()
    }
    
    func loadApi() {
        viewModel.loadAPIForHome { [weak self] (reslut) in
            guard let self = self else { return }
            switch reslut {
            case .success:
                self.collectionView.reloadData()
            case .failure(let error):
                self.alert(error: error)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionVIew: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.collectionViewCell, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Config.screenWidth / 2, height: (Config.screenWidth / 3) * 7 / 4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Config.minimumInteritemSpacingForSectionAt)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Config.minimumInteritemSpacingForSectionAt)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController {
    struct Config {
        static let numberOfItemsInSection: Int = 6
        static let minimumLineSpacingForSectionAt: Float = 5
        static let minimumInteritemSpacingForSectionAt: Int = 5
        static let screenWidth = UIScreen.main.bounds.width - 30
    }

    struct Identifier {
        static let collectionViewCell = "CollectionViewCell"
    }
}

