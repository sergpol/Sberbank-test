//
//  SecondViewController.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var translateResults: [TranslateResult] = []
    var searchedTranslateResults: [TranslateResult] = []
    
    let interactor: HistoryInteractorProtocol! = HistoryInteractor()
    let configurator: HistoryConfiguratorProtocol! = HistoryConfigurator()
    
    var isSearching = false
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getHistory), for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         getHistory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configurator.configure(with: self)
    }
    
    @objc func getHistory() {
        translateResults = interactor.getTranslateHistory()
        searchedTranslateResults = translateResults
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    @objc func searchHistory() {
        searchedTranslateResults = interactor.searchTranslateHistory(text: searchController.searchBar.text ?? "")
        tableView.reloadData()
    }
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        interactor.deleteAll(completion: { [weak self] (success) in
            if success {
                self?.translateResults.removeAll()
                self?.tableView.reloadData()
            }
        })
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchedTranslateResults.count : translateResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryCell
        let translateResult = isSearching ? searchedTranslateResults[indexPath.row] : translateResults[indexPath.row]
        cell.txtLabel?.text = translateResult.text
        cell.translatedTextLabel?.text = translateResult.translatedText
        return cell
    }
}

extension HistoryViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchHistory), object: searchBar)
        perform(#selector(searchHistory), with: searchBar, afterDelay: 0.25)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchedTranslateResults.removeAll()
        tableView.reloadData()
    }
}
