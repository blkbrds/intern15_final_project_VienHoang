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
        configCollectionView()
    }

    private func configCollectionView() {
        let nib = UINib(nibName: Identifier.collectionViewCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Identifier.collectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Config.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.collectionViewCell, for: indexPath) as? CollectionViewCell
            else { return UICollectionViewCell()
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Config.screenWidth / 2, height: (Config.screenWidth / 3) * 7 / 4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Config.minimumLineSpacingForSectionAt)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Config.minimumLineSpacingForSectionAt)
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

