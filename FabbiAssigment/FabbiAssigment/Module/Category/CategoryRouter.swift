//
//  CategoryRouter.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//  
//

import UIKit

protocol ViewToRouterCategoryProtocol: AnyObject {
    func goToRestaurantVC()
}

protocol DataPassingCategoryProtocol {
    var dataStore: DataStoreCategoryProtocol? { get }
}

final class CategoryRouter: DataPassingCategoryProtocol {
    
    // MARK: - Public Variable
    
    weak var view: CategoryViewController?
    var dataStore: DataStoreCategoryProtocol?
}

// MARK: - ViewToRouter

extension CategoryRouter: ViewToRouterCategoryProtocol {
    func goToRestaurantVC() {
        let storyboard = UIStoryboard(name: "Restaurant", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: String(describing: RestaurantViewController.self)) as! RestaurantViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToRestaurant(source: dataStore!, destination: &destinationDS)
        navigateToRestaurant(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToRestaurant(source: CategoryViewController,
                             destination: RestaurantViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing Data
    
    func passDataToRestaurant(source: DataStoreCategoryProtocol,
                             destination: inout DataStoreRestaurantProtocol) {
        guard let model = source.orderModel else {return}
        destination.orderModel = model
    }
}
