//
//  CategoryInteractor.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//  
//

import Foundation

protocol ViewToInteractorCategoryProtocol {
    func updateMeal()
    func updateOrder(meal: String?, numberOfPeople: Int?)
    func checkMealTextField(text: String?) -> Bool
    func checkNumberOfPeopleTextField(text: String?) -> Bool 
    func handlerError(meal: String?, numberOfPeople: String?)
}

protocol DataStoreCategoryProtocol {
    var orderModel: OrderModel? { get set }
}

final class CategoryInteractor: DataStoreCategoryProtocol {

    // MARK: - Public Variable
    
    var presenter: InteractorToPresenterCategoryProtocol?
    var worker: InteractorToWorkerCategoryProtocol?
    var orderModel: OrderModel?
    
    // MARK: - Private Variable
    
}

// MARK: - ViewToInteractor

extension CategoryInteractor: ViewToInteractorCategoryProtocol {
    func updateMeal() {
        let mealModel: [String?] = [R.string.localizable.breakfast(),
                         R.string.localizable.lunch(),
                         R.string.localizable.dinner()]
        presenter?.showMeal(with: mealModel)
    }
    
    func updateOrder(meal: String?, numberOfPeople: Int?) {
        let order = OrderModel(meal: meal,
                                    numerOfPeople: numberOfPeople,
                                    restaurant: nil,
                                    dishes: nil)
        orderModel = order
    }
    
    func checkMealTextField(text: String?) -> Bool {
        return !Utils.isNilOrEmpty(text)
    }

    func checkNumberOfPeopleTextField(text: String?) -> Bool {
        if let number = Int(text ?? "") {
            return number <= 10
        }
        return false
    }
    
    func handlerError(meal: String?, numberOfPeople: String?) {
        if !checkMealTextField(text: meal) {
            presenter?.showMealError()
        } else if !checkNumberOfPeopleTextField(text: numberOfPeople) {
            presenter?.showNumberOfPeopleError()
        }
    }
}

// MARK: - Private

private extension CategoryInteractor {}
