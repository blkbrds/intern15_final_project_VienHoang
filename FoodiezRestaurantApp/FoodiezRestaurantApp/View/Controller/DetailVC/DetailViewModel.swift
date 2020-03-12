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

    init(menu: Menus) {
        self.menu = menu
    }
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
    
    func loadApiSlide(completion: @escaping APICompletion) {
        guard let id = menu?.id else {
            return
        }
        Api.Path.Detail.vien = id
        let params = Api.Detail.Params(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: "20162502", ll: "16.0776738,108.197205")
        Api.Detail.getLocation(params: params) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let channel):
                self.menu?.detailImage = channel
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func viewModelForDetailViewModel() -> SlideImageViewModel? {
        guard let menu = menu else {
            return nil
        }
        return SlideImageViewModel(menu: menu)
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
