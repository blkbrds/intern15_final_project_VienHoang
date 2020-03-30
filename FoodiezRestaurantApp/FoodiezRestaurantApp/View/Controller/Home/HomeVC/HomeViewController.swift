//
//  HomeViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Life cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

final class HomeViewController: BaseViewController {

    //MARK: - IBOutlet
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!

    //MARK: - Properties
    var viewModel = HomeViewModel()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }

    //MARK: - Private functions
    private func setupUI() {
        let nib = UINib(nibName: App.Identifier.collectionViewCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: App.Identifier.collectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    //MARK: - Public functions
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
}

//MARK: - Extention CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionVIew: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: App.Identifier.collectionViewCell, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }
}

//MARK: - Extension CollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Config.widthSize, height: Config.heightSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Config.minimumLineSpacingForSectionAt)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat (Config.minimumInteritemSpacingForSectionAt)
    }
}

//MARK: - Extension CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetailCell(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Extension HomeViewController
extension HomeViewController {
    struct Config {
        static let minimumLineSpacingForSectionAt: Float = 10
        static let minimumInteritemSpacingForSectionAt: CGFloat = 10
        static let screenWidth = UIScreen.main.bounds.width - 30
        static let widthSize = (Config.screenWidth / 2) - 15
        static let heightSize = (Config.screenWidth / 3) * 6 / 4
    }
}

