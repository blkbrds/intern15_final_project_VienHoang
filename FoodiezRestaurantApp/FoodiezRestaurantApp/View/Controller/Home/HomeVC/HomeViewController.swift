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

    private var collectionViewCell = "CollectionViewCell"
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        configCollectionView()
    }

    private func configCollectionView() {
        let nib = UINib(nibName: collectionViewCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCell, for: indexPath) as? CollectionViewCell
            else { return UICollectionViewCell()
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 30
        _ = UIScreen.main.bounds.height
        return CGSize(width: screenWidth / 2, height: (screenWidth / 3) * 7 / 4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}



