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
    func deleteTranslate(text: String, translatedText: String, completion: (Bool) -> Void)
    func deleteAll(completion: (Bool) -> Void)
}

class HistoryInteractor: HistoryInteractorProtocol {
    var managedContext: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func getTranslateHistory() -> [TranslateResult] {
        guard let managedContext = self.managedContext else {
            return []
        }
    
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
        guard let managedContext = self.managedContext else {
            return []
        }
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
        guard let managedContext = self.managedContext else {
            completion(false)
            return
        }
        
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
    
    func deleteTranslate(text: String, translatedText: String, completion: (Bool) -> Void) {
        guard let managedContext = self.managedContext else {
            completion(false)
            return
        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TranslateResult")
        fetchRequest.predicate = NSPredicate(format: "(text == %@) AND (translatedText == %@)", text, translatedText)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
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
