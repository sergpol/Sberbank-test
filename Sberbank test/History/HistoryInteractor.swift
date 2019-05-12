//
//  HistoryInteractor.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 12/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol HistoryInteractorProtocol: class {
    func getTranslateHistory() -> [TranslateResult]
    func searchTranslateHistory(text: String) -> [TranslateResult]
    func deleteAll(completion: (Bool) -> Void)
}

class HistoryInteractor: HistoryInteractorProtocol {
    func getTranslateHistory() -> [TranslateResult] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TranslateResult>(entityName: "TranslateResult")
        
        var translateResults: [TranslateResult] = []
        
        do {
            translateResults = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return translateResults
    }
    
    func searchTranslateHistory(text: String) -> [TranslateResult] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TranslateResult>(entityName: "TranslateResult")
        fetchRequest.predicate = NSPredicate(format: "(text contains[cd] %@) OR (translatedText contains[cd] %@)", text, text)
        
        var translateResults: [TranslateResult] = []
        
        do {
            translateResults = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return translateResults
    }
    
    func deleteAll(completion: (Bool) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TranslateResult")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            completion(true)
        }
        catch {
            completion(false)
            print ("There was an error")
        }
    }
}
