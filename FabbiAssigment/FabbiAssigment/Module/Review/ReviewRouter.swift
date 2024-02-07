//
//  ReviewRouter.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import UIKit

protocol ViewToRouterReviewProtocol: AnyObject {
    func goToFinish()
    func backToDishes()
}

protocol DataPassingReviewProtocol {
    var dataStore: DataStoreReviewProtocol? { get }
}

final class ReviewRouter: DataPassingReviewProtocol {
    
    // MARK: - Public Variable
    
    weak var view: ReviewViewController?
    var dataStore: DataStoreReviewProtocol?
}

// MARK: - ViewToRouter

extension ReviewRouter: ViewToRouterReviewProtocol {
    func backToDishes() {
        guard let destinationVC = view?.navigationController?.viewControllers.first(where: { $0 is DishesViewController }) as? DishesViewController else { return }
        navigateToDished(source: view!, destination: destinationVC)
    }
    
    func goToFinish() {
        let storyboard = UIStoryboard(name: "Finish", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: String(describing: FinishViewController.self)) as! FinishViewController
        var destinationDS = destinationVC.router!.dataStore!
        navigateToFinish(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToDished(source: ReviewViewController,
                             destination: DishesViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    func navigateToFinish(source: ReviewViewController,
                             destination: FinishViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}
