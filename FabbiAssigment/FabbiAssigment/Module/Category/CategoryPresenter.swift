//
//  CategoryPresenter.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//  
//

import Foundation

protocol InteractorToPresenterCategoryProtocol {
    func showMeal(with meal: [String?])
    func showMealError()
    func showNumberOfPeopleError()
}

final class CategoryPresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewCategoryProtocol?
}

// MARK: - InteractorToPresenter

extension CategoryPresenter: InteractorToPresenterCategoryProtocol {
    func showMealError() {
        view?.showMealErrorAlert()
    }
    
    func showNumberOfPeopleError() {
        view?.showNumberOfPeopleErrorAlert()
    }
    
    func showMeal(with meal: [String?]) {
        view?.getMealData(meal: meal)
    }
}

// MARK: - Private

private extension CategoryPresenter {}
