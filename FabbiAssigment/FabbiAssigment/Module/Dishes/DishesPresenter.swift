//
//  DishesPresenter.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import Foundation

protocol InteractorToPresenterDishesProtocol {
    func showDishes(with dishes: Dishes.Dishes.ViewModel)
    func showDishError()
    func showNoServingError()
    func showTotalDishesError()
}

final class DishesPresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewDishesProtocol?
}

// MARK: - InteractorToPresenter

extension DishesPresenter: InteractorToPresenterDishesProtocol {
    func showDishError() {
        view?.showDishesErrorAlert()
    }
    
    func showNoServingError() {
        view?.showNoServingErrorAlert()
    }
    
    func showTotalDishesError() {
        view?.showTotalDishesErrorAlert()
    }
    
    func showDishes(with dishes: Dishes.Dishes.ViewModel) {
        view?.reloadTableViewData(with: dishes)
    }
}

// MARK: - Private

private extension DishesPresenter {}
