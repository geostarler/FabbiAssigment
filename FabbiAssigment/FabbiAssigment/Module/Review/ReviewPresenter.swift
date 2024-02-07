//
//  ReviewPresenter.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import Foundation

protocol InteractorToPresenterReviewProtocol {
    func showOrder(with order: OrderModel)
}

final class ReviewPresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewReviewProtocol?
}

// MARK: - InteractorToPresenter

extension ReviewPresenter: InteractorToPresenterReviewProtocol {
    func showOrder(with order: OrderModel) {
        view?.updateUI(order: order)
    }
}

// MARK: - Private

private extension ReviewPresenter {}
