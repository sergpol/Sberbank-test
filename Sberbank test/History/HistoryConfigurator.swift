//
//  HistoryConfigurator.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 12/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

protocol HistoryConfiguratorProtocol: class {
    func configure(with viewController: HistoryViewController)
}

class HistoryConfigurator: HistoryConfiguratorProtocol {
    func configure(with viewController: HistoryViewController) {
        
        viewController.definesPresentationContext = true
        
        viewController.searchController.dimsBackgroundDuringPresentation = false
        viewController.searchController.searchResultsUpdater = viewController
        viewController.searchController.searchBar.delegate = viewController
        viewController.searchController.searchBar.barTintColor = UIColor.black
        
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
        viewController.navigationItem.searchController = viewController.searchController
        
        viewController.tableView.estimatedRowHeight = 44
        viewController.tableView.addSubview(viewController.refreshControl)
        viewController.tableView.tableFooterView = UIView()
    }
}
