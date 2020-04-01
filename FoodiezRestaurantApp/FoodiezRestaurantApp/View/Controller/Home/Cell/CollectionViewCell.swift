//
//  CollectionViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func cell(_ cell: CollectionViewCell, needPerforms action: CollectionViewCell.Action)
}

final class CollectionViewCell: UICollectionViewCell {

    enum Action {
        case getImage(indexPath: IndexPath?)
    }

    //MARK: - IBOutlet
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var nameImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var thumbnailImage: UIImageView!

    //MARK: - Properties
    weak var delegate: CollectionViewCellDelegate?
    var indexPath: IndexPath?
    var viewModel: CollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.nameImageView.layer.cornerRadius = self.nameImageView.frame.width / 2
            self.layer.cornerRadius = 40
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.blurView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.blurView.addSubview(blurEffectView)
        }
    }

    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    //MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        if let image = viewModel.image {
            thumbnailImage.setImage(url: image)
        } else {
            thumbnailImage.image = nil
            delegate?.cell(self, needPerforms: .getImage(indexPath: indexPath))
        }
        nameLabel.text = viewModel.name
        let image = "\(viewModel.prefix)bg_88\(viewModel.suffix)"
        nameImageView.setImage(url: image)
        if let image = viewModel.image {
            thumbnailImage.setImage(url: image)
        } else {
            thumbnailImage.image = nil
            delegate?.cell(self, needPerforms: .getImage(indexPath: indexPath))
        }
    }
}



