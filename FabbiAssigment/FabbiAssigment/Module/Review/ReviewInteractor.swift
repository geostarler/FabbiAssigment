//
//  ReviewInteractor.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import Foundation

protocol ViewToInteractorReviewProtocol {
    func getOrder()
}

protocol DataStoreReviewProtocol {
    var dataStore: DataStoreReviewProtocol? { get }
    var orderModel: OrderModel? { get set }
}

final class ReviewInteractor: DataStoreReviewProtocol {
    var dataStore: DataStoreReviewProtocol?
    
    var orderModel: OrderModel?
    
    
    // MARK: - Public Variable
    
    var presenter: InteractorToPresenterReviewProtocol?
    var worker: InteractorToWorkerReviewProtocol?
    
    // MARK: - Private Variable
    
}

// MARK: - ViewToInteractor

extension ReviewInteractor: ViewToInteractorReviewProtocol {
    func getOrder() {
        guard let orderModel = orderModel else { return }
        presenter?.showOrder(with: orderModel)
    }
}

// MARK: - Private

private extension ReviewInteractor {}
