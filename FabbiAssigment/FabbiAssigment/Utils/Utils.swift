//
//  Util.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//

import Foundation

class Utils: NSObject {
    static func decodeUser(from file: String) -> DishesModel? {
        do {
            guard let fileURL = Bundle.main.url(forResource: file, withExtension: "json") else {
                print("File not found")
                return nil
            }
            let jsonData = try Data(contentsOf: fileURL)
            let dishes = try JSONDecoder().decode(DishesModel.self, from: jsonData)
            return dishes
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    static func removeDuplicates(_ array: [String]) -> [String] {
        var uniqueElements = Set<String>()
        var result = [String]()
        for element in array {
            if uniqueElements.insert(element).inserted {
                result.append(element)
            }
        }
        return result
    }
    
    static func isNilOrEmpty(_ string: String?) -> Bool {
        if let string = string {
            return string.isEmpty
        } else {
            return true
        }
    }
}
