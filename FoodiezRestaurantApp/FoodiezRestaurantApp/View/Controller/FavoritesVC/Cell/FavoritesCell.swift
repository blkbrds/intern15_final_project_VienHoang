//
//  FavoritesTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/24/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class FavoritesCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet private weak var addressLocationLabel: UILabel!
    @IBOutlet private weak var ratingLocationLabel: UILabel!
    @IBOutlet private weak var nameLocationLabel: UILabel!
    @IBOutlet private weak var locationImageView: UIImageView!
    
    //MARK: - Lyfe cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
