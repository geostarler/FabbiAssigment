//
//  FinishRouter.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import UIKit

protocol ViewToRouterFinishProtocol: AnyObject {
    func goToCategory()
}

protocol DataPassingFinishProtocol {
    var dataStore: DataStoreFinishProtocol? { get }
}

final class FinishRouter: DataPassingFinishProtocol {
    
    // MARK: - Public Variable
    
    weak var view: FinishViewController?
    var dataStore: DataStoreFinishProtocol?
}

// MARK: - ViewToRouter

extension FinishRouter: ViewToRouterFinishProtocol {
    func goToCategory() {
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: String(describing: CategoryViewController.self)) as! CategoryViewController
        navigateToCategory(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToCategory(source: FinishViewController,
                             destination: CategoryViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}
