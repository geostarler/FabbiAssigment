//
//  RestaurantRouter.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import UIKit

protocol ViewToRouterRestaurantProtocol: AnyObject {
    func backToCategory()
    func goToDished()
}

protocol DataPassingRestaurantProtocol {
    var dataStore: DataStoreRestaurantProtocol? { get }
}

final class RestaurantRouter: DataPassingRestaurantProtocol {
    
    // MARK: - Public Variable
    
    weak var view: RestaurantViewController?
    var dataStore: DataStoreRestaurantProtocol?
}

// MARK: - ViewToRouter

extension RestaurantRouter: ViewToRouterRestaurantProtocol {
    func backToCategory() {
        guard let destinationVC = view?.navigationController?.viewControllers.first(where: { $0 is CategoryViewController }) as? CategoryViewController else { return }
        navigateToCategory(source: view!, destination: destinationVC)
    }
    
    func goToDished() {
        let storyboard = UIStoryboard(name: "Dishes", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: String(describing: DishesViewController.self)) as! DishesViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDishes(source: dataStore!, destination: &destinationDS)
        navigateToDishes(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToCategory(source: RestaurantViewController,
                             destination: CategoryViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDishes(source: RestaurantViewController,
                             destination: DishesViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing Data
    
    func passDataToDishes(source: DataStoreRestaurantProtocol,
                             destination: inout DataStoreDishesProtocol) {
        guard let model = source.orderModel else {return}
        destination.orderModel = model
    }
}
