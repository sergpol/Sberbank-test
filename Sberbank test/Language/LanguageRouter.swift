//
//  LanguageRouter.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 12/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

protocol LanguageRouterProtocol: class {
    func closeCurrentViewController()
}

class LanguageRouter: LanguageRouterProtocol {
    weak var viewController: LanguageViewController!
    
    init(viewController: LanguageViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
