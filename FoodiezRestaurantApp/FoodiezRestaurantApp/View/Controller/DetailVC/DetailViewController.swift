//
//  DetailViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/9/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        setupUI()
    }
    
      private func setupUI () {
        tableView.register(name: CellIdentifier.slideImageCell.rawValue)
        tableView.register(name: CellIdentifier.contactCell.rawValue)
        tableView.register(name: CellIdentifier.mapDetailCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
      }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = DetailViewModel.SectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch type {
        case .slideImageCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.slideImageCell.rawValue, for: indexPath) as? SlideImageCell else {
                return UITableViewCell()
            }
            return cell
        case .contact:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.contactCell.rawValue, for: indexPath) as? ContactCell else {
                return UITableViewCell()
            }
            return cell
        case .mapDetail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.mapDetailCell.rawValue, for: indexPath) as? MapDetailCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(at: indexPath)
    }
}
