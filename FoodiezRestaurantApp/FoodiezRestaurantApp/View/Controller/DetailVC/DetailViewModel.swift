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

    enum SectionType: Int, CaseIterable {
        case slideImageCell
        case contact
        case mapDetail
    }
    var menu: Menu?

    //MARK: - Public functions
    func numberOfSections() -> Int {
        return SectionType.allCases.count
    }

    func numberOfRows(in section: Int) -> Int {
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
    struct Config {
        static let numberOfRowsInSection: Int = 1
    }
}
