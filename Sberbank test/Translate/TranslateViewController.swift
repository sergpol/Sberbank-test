//
//  FirstViewController.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

protocol TranslateViewProtocol {
    func setTitleView()
    func setSourceLanguage(language: Language)
    func setDestinationLanguage(language: Language)
    func swapLanguage(sourceLanguage: Language, destinationLanguage: Language)
    func sourceLanguageButtonTap()
    func destinationLanguageButtonTap()
    func swapLanguageButtonTap()
}

class TranslateViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let interactor: TranslateInteractorProtocol! = TranslateInteractor()
    var presenter: TranslatePresenterProtocol!
    let configurator: TranslateConfiguratorProtocol! = TranslateConfigurator()
    
    var sourceLanguage: Language!
    var destinationLanguage: Language!
    
    var sourceText: String = ""
    var translatedText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TranslatePresenter(view: self)
        configurator.configure(with: self)
        presenter.configureView()
        
        makeTranslate()
    }
    
    @objc func performTranslate(_ sender: UITextView) {
        sourceText = sender.text
        makeTranslate()
    }
    
    func makeTranslate() {
        if sourceText.isEmpty {
            tableView.reloadData()
        }
        else {
            interactor.getTranslateResult(text: sourceText, direction: "\(sourceLanguage.code)-\(destinationLanguage.code)", completion: { [weak self] (result) in
                print("# translates: \(result)")
                self?.translatedText = result.joined()
                DispatchQueue.main.async {
                    self?.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
                }
            })
        }
    }
    
    @IBAction func onLanguageSelected(segue: UIStoryboardSegue) {
        if let vc = segue.source as? LanguageViewController {
            if vc.selectSourceLanguage {
                setSourceLanguage(language: vc.selectedLanguage)
            }
            else {
                setDestinationLanguage(language: vc.selectedLanguage)
            }
        }
        
        makeTranslate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectSourceLanguage" {
            if let vc = segue.destination.children[0] as? LanguageViewController {
                vc.selectedLanguage = sourceLanguage
                vc.selectSourceLanguage = true
            }
        }
        if segue.identifier == "toSelectDestinationLanguage" {
            if let vc = segue.destination.children[0] as? LanguageViewController {
                vc.selectedLanguage = destinationLanguage
                vc.selectSourceLanguage = false
            }
        }
    }
}

extension TranslateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TranslateCell
        switch indexPath.row {
        case 0:
            cell.textViewDidChangeCompletion = { [weak self] in
                guard let self = self else { return }
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.performTranslate(_:)), object: cell.textView)
                self.perform(#selector(self.performTranslate(_:)), with: cell.textView, afterDelay: 0.5)
            }
        default:
            cell.textView.text = translatedText
            cell.placeholderLabel.isHidden = true
        }
        return cell
    }
}

extension TranslateViewController: TranslateViewProtocol {
    
    func setTitleView() {
        let titleView = TranslateTitleView(frame: CGRect(x: 0, y: 0, width: 160, height: 44))
        titleView.presenter = presenter as? TranslatePresenter
        navigationItem.titleView = titleView
        
        titleView.sourseLangButton.setTitle(sourceLanguage.name, for: .normal)
        titleView.destinationLangButton.setTitle(destinationLanguage.name, for: .normal)
    }
    
    func setSourceLanguage(language: Language) {
        sourceLanguage = language
        if let titleView = navigationItem.titleView as? TranslateTitleView {
            titleView.sourseLangButton.setTitle(sourceLanguage.name, for: .normal)
        }
    }
    
    func setDestinationLanguage(language: Language) {
        destinationLanguage = language
        if let titleView = navigationItem.titleView as? TranslateTitleView {
            titleView.destinationLangButton.setTitle(destinationLanguage.name, for: .normal)
        }
    }
    
    func swapLanguage(sourceLanguage: Language, destinationLanguage: Language) {
        setSourceLanguage(language: destinationLanguage)
        setDestinationLanguage(language: sourceLanguage)
        makeTranslate()
    }
    
    func sourceLanguageButtonTap() {
        performSegue(withIdentifier: "toSelectSourceLanguage", sender: self)
    }
    
    func destinationLanguageButtonTap() {
        performSegue(withIdentifier: "toSelectDestinationLanguage", sender: self)
    }
    
    func swapLanguageButtonTap() {
        swapLanguage(sourceLanguage: sourceLanguage, destinationLanguage: destinationLanguage)
    }
}
