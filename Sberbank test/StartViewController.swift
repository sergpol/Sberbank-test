//
//  StartViewController.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = .white
        }, completion: { (finished) in
            self.performSegue(withIdentifier: "toStartApp", sender: self)
        })
    }
}
