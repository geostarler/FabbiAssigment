//
//  RestaurantPresenter.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import Foundation

protocol InteractorToPresenterRestaurantProtocol {
    func showRestaurant(with restaurant: [String?])
    func showRestaurantError()
}

final class RestaurantPresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewRestaurantProtocol?
}

// MARK: - InteractorToPresenter

extension RestaurantPresenter: InteractorToPresenterRestaurantProtocol {
    func showRestaurant(with restaurant: [String?]) {
        view?.getRestaurantData(restaurant: restaurant)
    }
    
    func showRestaurantError() {
        view?.showRestaurantErrorAlert()
    }
}

// MARK: - Private

private extension RestaurantPresenter {}
