//
//  TranslateConfigurator.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

protocol TranslateConfiguratorProtocol: class {
    func configure(with viewController: TranslateViewController)
}

class TranslateConfigurator: TranslateConfiguratorProtocol {
    func configure(with viewController: TranslateViewController) {
        viewController.sourceLanguage = Language(name: "English", code: "en")
        viewController.destinationLanguage = Language(name: "Russian", code: "ru")
        
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
        
        viewController.tableView.tableFooterView = UIView()
        viewController.tableView.estimatedRowHeight = 160
    }
}
