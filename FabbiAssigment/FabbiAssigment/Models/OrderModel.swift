//
//  OrderModel.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//

import Foundation

struct OrderModel: Decodable {
    var meal: String?
    var numerOfPeople: Int?
    var restaurant: String?
    var dishes: [SelectedDishModel]?
}
