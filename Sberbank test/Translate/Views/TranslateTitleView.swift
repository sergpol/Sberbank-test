//
//  TranslateTitleView.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class TranslateTitleView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sourseLangButton: UIButton!
    @IBOutlet weak var destinationLangButton: UIButton!
    @IBOutlet weak var changeTranslateDirectionButton: UIButton!
    
    var presenter: TranslatePresenter!
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    fileprivate func setup() {
        loadNib()
        
        self.addSubview(contentView)
        
        self.addConstraints([
            
            NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            
            ])
    }
    
    fileprivate func loadNib() {
        let bundle = Bundle(for: TranslateTitleView.classForCoder())
        bundle.loadNibNamed("TranslateTitleView", owner: self, options: nil)
    }
    
    @IBAction func sourceLangButtonTap(_ sender: UIButton) {
        presenter.sourceLanguageButtonTap()
    }
    
    @IBAction func destinationLangButtonTap(_ sender: UIButton) {
        presenter.destinationLanguageButtonTap()
    }
    
    @IBAction func swapLanguageButtonTap(_ sender: UIButton) {
        presenter.swapLanguageButtonTap()
    }
}
