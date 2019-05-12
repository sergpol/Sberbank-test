//
//  LanguageViewController.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class LanguageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var languages: [Language] = []
    var selectedLanguage: Language!
    var selectSourceLanguage = true
    
    var configurator: LanguageConfiguratorProtocol! = LanguageConfigurator()
    var router: LanguageRouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        router = LanguageRouter(viewController: self)
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        router.closeCurrentViewController()
    }
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = languages[indexPath.row].name
        
        if let selLang = selectedLanguage, selLang.code == languages[indexPath.row].code {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguage = languages[indexPath.row]
        performSegue(withIdentifier: "onLanguageSelected", sender: self)
    }
}
