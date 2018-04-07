//
//  JsonHandler.swift
//  MiviTest
//
//  Created by Moriarty on 06/04/18.
//  Copyright © 2018 Ramdhas. All rights reserved.
//

import Foundation


protocol JsonHandlerDelegate: class {
    func didCompleteRequest(result: NSDictionary, message: String)
}

class JsonHandler: NSObject {
    weak var delegate: JsonHandlerDelegate?
    var parseError : NSError?
    func fetchDataFromJsonFile() {
        let path = Bundle.main.url(forResource: kJsonFile, withExtension: "json")
        let jsonResult : NSDictionary = [:]

        /*Checking file path */
        guard path != nil else {
            return (delegate?.didCompleteRequest(result: jsonResult, message: kIncorrectFile))!
        }

        do {
            let jsonData = try Data(contentsOf: path!, options: .mappedIfSafe)
            do {
                if let parsedResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary {
                    delegate?.didCompleteRequest(result: parsedResult, message: kSuccess)
                }
            } catch let error as NSError {
                parseError = error
                delegate?.didCompleteRequest(result: jsonResult, message: error.localizedDescription)
            }
        } catch let error as NSError {
            parseError = error
            delegate?.didCompleteRequest(result: jsonResult, message: error.localizedDescription)
        }
    }
}
