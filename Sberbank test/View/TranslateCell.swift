//
//  TranslateCell.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class TranslateCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!

    var textViewDidChangeCompletion: () -> Void = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
    }
}

extension TranslateCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        UIView.animate(withDuration: 0.25, animations: {
            self.placeholderLabel.alpha = textView.text.isEmpty ? 1 : 0
        })
        
        if !textView.text.isEmpty {
            textViewDidChangeCompletion()
        }
    }
}
