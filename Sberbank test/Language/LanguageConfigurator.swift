//
//  LanguageConfigurator.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 12/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

protocol LanguageConfiguratorProtocol {
    func configure(with viewController: LanguageViewController)
}

class LanguageConfigurator: LanguageConfiguratorProtocol {
    func configure(with viewController: LanguageViewController) {
        viewController.languages = [Language(name: "English", code: "en"),
                                    Language(name: "Russian", code: "ru"),
                                    Language(name: "Spanish", code: "es")]
    }
}
