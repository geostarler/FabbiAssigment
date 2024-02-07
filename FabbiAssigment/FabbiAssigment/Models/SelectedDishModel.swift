//
//  SelectedDishModel.swift
//  FabbiAssigment
//
//  Created by Maoo on 05/02/2024.
//

import Foundation

struct SelectedDishModel: Decodable, Hashable {
    var dish: String?
    var noOfServing: Int?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(dish)
        hasher.combine(noOfServing)
    }

    static func ==(lhs: SelectedDishModel, rhs: SelectedDishModel) -> Bool {
        return lhs.dish == rhs.dish && lhs.noOfServing == rhs.noOfServing
    }
}
