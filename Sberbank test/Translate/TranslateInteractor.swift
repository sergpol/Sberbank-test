//
//  TranslateInteractor.swift
//  Sberbank test
//
//  Created by Сергей Полицинский on 11/05/2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol TranslateInteractorProtocol: class {
    var urlTranslateSource: String { get }
    func getSupportedLangs(text: String, completion: (([String]) -> Void)?)
    func getTranslateResult(text: String, direction: String, completion: (([String]) -> Void)?)
    func saveTranslateResult(text: String, translatedText: String?)
}

class TranslateInteractor: TranslateInteractorProtocol {
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    var apiKey: String {
        return "trnsl.1.1.20190511T102931Z.563776e8048a9af1.5c67b5a54aaadefd1e50607d44c8aa00e303efab"
    }
    
    var urlSupportLangSource: String {
        return "https://translate.yandex.net/api/v1.5/tr.json/getLangs"
    }
    
    var urlTranslateSource: String {
        return "https://translate.yandex.net/api/v1.5/tr.json/translate"
    }
    
    func getSupportedLangs(text: String, completion: (([String]) -> Void)?) {
        let url = URL(string: "\(urlTranslateSource)?key=\(apiKey)&lang=ru&text=\(text)")!
        let task = URLSession(configuration: .default).dataTask(with: url) { [unowned self] data, response, error in
            var errorString: String?
            if let error = error {
                errorString = error.localizedDescription
            } else if let data = data, let langs = try? self.decoder.decode([String].self, from: data) {
                print("# translates: \(langs)")
            } else {
                errorString = "Неизвестная ошибка"
            }
            //completion?(errorString)
        }
        task.resume()
    }
    
    func getTranslateResult(text: String, direction: String, completion: (([String]) -> Void)?) {
        let url = URL(string: "\(urlTranslateSource)?key=\(apiKey)&lang=\(direction)&text=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        print(url.absoluteString)
        let task = URLSession(configuration: .default).dataTask(with: url) { [unowned self] data, response, error in
            var errorString: String?
            if let error = error {
                errorString = error.localizedDescription
                completion?([errorString!])
            } else if let data = data, let translate = try? self.decoder.decode(Translate.self, from: data) {
                completion?(translate.text ?? [""])
            } else {
                errorString = "Неизвестная ошибка"
                completion?([errorString!])
            }
        }
        task.resume()
    }
    
    func saveTranslateResult(text: String, translatedText: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "TranslateResult", in: managedContext)!
        let translateResult = NSManagedObject(entity: entity, insertInto: managedContext)
        translateResult.setValue(text, forKeyPath: "text")
        translateResult.setValue(translatedText, forKeyPath: "translatedText")
        do {
            try managedContext.save()
            print("#Saved!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
