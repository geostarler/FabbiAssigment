//
//  DishesRouter.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import UIKit

protocol ViewToRouterDishesProtocol: AnyObject {
    func goToReview()
    func backToRestaurent()
}

protocol DataPassingDishesProtocol {
    var dataStore: DataStoreDishesProtocol? { get }
}

final class DishesRouter: DataPassingDishesProtocol {
    
    // MARK: - Public Variable
    
    weak var view: DishesViewController?
    var dataStore: DataStoreDishesProtocol?
}

// MARK: - ViewToRouter

extension DishesRouter: ViewToRouterDishesProtocol {
    func backToRestaurent() {
        guard let destinationVC = view?.navigationController?.viewControllers.first(where: { $0 is RestaurantViewController }) as? RestaurantViewController else { return }
        navigateToRestaurant(source: view!, destination: destinationVC)
    }
    
    func goToReview() {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: String(describing: ReviewViewController.self)) as! ReviewViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToReview(source: dataStore!, destination: &destinationDS)
        navigateToReview(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToRestaurant(source: DishesViewController,
                             destination: RestaurantViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    func navigateToReview(source: DishesViewController,
                             destination: ReviewViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing Data
    
    func passDataToReview(source: DataStoreDishesProtocol,
                             destination: inout DataStoreReviewProtocol) {
        guard let model = source.orderModel else {return}
        destination.orderModel = model
    }
}
