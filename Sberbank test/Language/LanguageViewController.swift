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
    
    var languages: [Language] = [Language(name: "English", code: "en"),
                                Language(name: "Russian", code: "ru"),
                                Language(name: "Spanish", code: "es")]
    var selectedLanguage: Language!
    var selectSourceLanguage = true
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
