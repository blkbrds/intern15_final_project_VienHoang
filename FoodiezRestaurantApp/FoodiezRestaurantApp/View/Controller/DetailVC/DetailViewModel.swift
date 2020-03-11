//
//  DetailViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import UIKit
final class DetailViewModel {
    var menu: Menus?

    func numberOfSections() -> Int {
        return SectionType.allCases.count
    }

    func numberOfRowsInSection(section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .slideImageCell, .contact, .mapDetail:
            return Config.numberOfRowsInSection
        }
    }

    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            return .zero
        }
        switch sectionType {
        case .slideImageCell, .contact, .mapDetail:
            return UITableView.automaticDimension
        }
    }
}
extension DetailViewModel {
    enum SectionType: Int, CaseIterable {
        case slideImageCell
        case contact
        case mapDetail
    }

    struct Config {
        static let numberOfRowsInSection: Int = 1
    }
}
