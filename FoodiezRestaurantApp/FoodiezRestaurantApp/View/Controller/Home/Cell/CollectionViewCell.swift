//
//  CollectionViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var nameImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    //MARK: - Properties
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
        nameLabel.text = viewModel.name
        let image = "\(viewModel.prefix)bg_88\(viewModel.suffix)"
        nameImageView.setImage(url: image)
    }
}



