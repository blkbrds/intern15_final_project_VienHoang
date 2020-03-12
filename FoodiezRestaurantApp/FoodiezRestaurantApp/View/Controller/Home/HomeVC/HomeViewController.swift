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
    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discovery"
        setupData()
        setupUI()
        setupBackground()
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.25) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
    
    func setupBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "hinhnen")
        view.sendSubviewToBack(backgroundImageView)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionVIew: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfIemsInSection(section: section)
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
        vc.viewModel = viewModel.detailViewModelForCell(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController {
    struct Config {
        static let minimumLineSpacingForSectionAt: Float = 5
        static let minimumInteritemSpacingForSectionAt: Int = 5
        static let screenWidth = UIScreen.main.bounds.width - 30
    }

    struct Identifier {
        static let collectionViewCell = "CollectionViewCell"
    }
}

