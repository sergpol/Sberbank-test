//
//  TranslatePresenter.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

protocol TranslatePresenterProtocol: class {
    var view: TranslateViewProtocol! { set get }
    var router: TranslateRouterProtocol! { set get }
    
    func configureView()
    
    func sourceLanguageButtonTap()
    func destinationLanguageButtonTap()
    func swapLanguageButtonTap()
}

class TranslatePresenter: TranslatePresenterProtocol {
    weak var view: TranslateViewProtocol!
    var router: TranslateRouterProtocol!
    
    required init(view: TranslateViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.setTitleView()
    }
    
    func sourceLanguageButtonTap() {
        view.sourceLanguageButtonTap()
    }
    
    
    func destinationLanguageButtonTap() {
        view.destinationLanguageButtonTap()
    }
    
    func swapLanguageButtonTap() {
        view.swapLanguageButtonTap()
    }
}
