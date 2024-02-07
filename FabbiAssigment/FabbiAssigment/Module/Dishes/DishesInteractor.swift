//
//  DishesInteractor.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import Foundation

protocol ViewToInteractorDishesProtocol {
    func updateOrder(dishModel: [SelectedDishModel])
    func reloadDishCell()
    func canGoNext(selectDishModel: [SelectedDishModel?]) -> Bool
    func checkDishesTextField(text: String?) -> Bool
    func checkNoServing(number: Int?) -> Bool
    func checkTotal(total: Int) -> Bool
    func handlerError(selectDishModel: [SelectedDishModel?])
}

protocol DataStoreDishesProtocol {
    var dataStore: DataStoreRestaurantProtocol? { get }
    var orderModel: OrderModel? { get set }
}

final class DishesInteractor: DataStoreDishesProtocol {
    
    // MARK: - Public Variable
    var dataStore: DataStoreRestaurantProtocol?
    var orderModel: OrderModel?
    var presenter: InteractorToPresenterDishesProtocol?
    var worker: InteractorToWorkerDishesProtocol?
    
    // MARK: - Private Variable
    
}

// MARK: - ViewToInteractor

extension DishesInteractor: ViewToInteractorDishesProtocol {
    
    func updateOrder(dishModel: [SelectedDishModel]) {
        orderModel?.dishes = dishModel
    }
    
    func canGoNext(selectDishModel: [SelectedDishModel?]) -> Bool {
        let setSelectDishModel = Set(selectDishModel)
        let checkNotHasSameDish = setSelectDishModel.count == selectDishModel.count
        let totalDish = selectDishModel.reduce(0) { $0 + ($1?.noOfServing ?? 1)}
        let checkTotalDish = checkTotal(total: totalDish)
        let checkDishIsSelected = selectDishModel.contains { checkDishesTextField(text: $0?.dish) }
        if checkNotHasSameDish && checkTotalDish && checkDishIsSelected && checkDishIsSelected {
            return true
        }
        return false
    }
    
    func reloadDishCell() {
        if let dishes = Utils.decodeUser(from: "dishes") {
            var dishesData: [String] = []
            for dish in dishes.dishes {
                if dish.availableMeals.contains(orderModel?.meal ?? "") && dish.restaurant == orderModel?.restaurant {
                    dishesData.append(dish.name)
                }
                dishesData = Utils.removeDuplicates(dishesData)
            }
            let dishesModel = Dishes.Dishes.ViewModel(dishes: dishesData)
            presenter?.showDishes(with: dishesModel)
        } else {
            print("Failed to decode User")
        }
    }
    
    func checkDishesTextField(text: String?) -> Bool {
        return !Utils.isNilOrEmpty(text)
    }

    func checkNoServing(number: Int?) -> Bool {
        if let number = number {
            return number <= 10
        }
        return false
    }
    
    func checkTotal(total: Int) -> Bool {
        return total >= orderModel?.numerOfPeople ?? 0 && total <= 10
    }
    
    func handlerError(selectDishModel: [SelectedDishModel?]) {
        for dish in selectDishModel {
            if !checkDishesTextField(text: dish?.dish) {
                presenter?.showDishError()
            } else if !checkNoServing(number: dish?.noOfServing) {
                presenter?.showNoServingError()
            }
        }
        let totalDish = selectDishModel.reduce(0) { $0 + ($1?.noOfServing ?? 1)}
        if !checkTotal(total: totalDish) {
            presenter?.showTotalDishesError()
        }
    }
    
}

// MARK: - Private

private extension DishesInteractor {}
