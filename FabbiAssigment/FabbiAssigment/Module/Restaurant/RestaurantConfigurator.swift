//
//  RestaurantConfigurator.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

final class RestaurantConfigurator {
    static func injectDependencies(for viewController: RestaurantViewController) {
        let interactor = RestaurantInteractor()
        let worker = RestaurantWorker()
        let presenter = RestaurantPresenter()
        let router = RestaurantRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = viewController
        
        router.view = viewController
        router.dataStore = interactor
    }
}
