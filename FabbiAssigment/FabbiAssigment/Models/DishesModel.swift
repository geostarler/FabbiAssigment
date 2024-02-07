//
//  DishesModel.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//

import Foundation

struct DishesModel: Decodable {
    let dishes: [DishModel]
}

struct DishModel: Decodable {
    let id: Int
    let name: String
    let restaurant: String
    let availableMeals: [String]
}
