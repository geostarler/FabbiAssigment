//
//  RestaurantInteractor.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import Foundation

protocol ViewToInteractorRestaurantProtocol {
    func updateRestaurant()
    func updateOrder(restaurant: String)
    func checkRestaurantTextField(text: String?) -> Bool
    func handlerError(restaurant: String?)
}

protocol DataStoreRestaurantProtocol {
    var dataStore: DataStoreRestaurantProtocol? { get }
    var orderModel: OrderModel? { get set }
}

final class RestaurantInteractor: DataStoreRestaurantProtocol {
    // MARK: - Public Variable
    
    var dataStore: DataStoreRestaurantProtocol?
    var orderModel: OrderModel?
    var presenter: InteractorToPresenterRestaurantProtocol?
    var worker: InteractorToWorkerRestaurantProtocol?
    
    // MARK: - Private Variable
    
}

// MARK: - ViewToInteractor

extension RestaurantInteractor: ViewToInteractorRestaurantProtocol {
    func updateOrder(restaurant: String) {
        orderModel?.restaurant = restaurant
    }
    
    func updateRestaurant() {
        if let dishes = Utils.decodeUser(from: "dishes") {
            var restaurant: [String] = []
            for dish in dishes.dishes {
                if dish.availableMeals.contains(orderModel?.meal ?? "") {
                    restaurant.append(dish.restaurant)
                }
                restaurant = Utils.removeDuplicates(restaurant)
            }
            presenter?.showRestaurant(with: restaurant)
        } else {
            print("Failed to decode User")
        }
    }
    
    func handlerError(restaurant: String?) {
        if !checkRestaurantTextField(text: restaurant) {
            presenter?.showRestaurantError()
        }
    }
    
    func checkRestaurantTextField(text: String?) -> Bool {
        return !Utils.isNilOrEmpty(text)
    }
}

// MARK: - Private

private extension RestaurantInteractor {}
