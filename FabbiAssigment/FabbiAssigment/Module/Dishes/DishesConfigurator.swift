//
//  DishesConfigurator.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

final class DishesConfigurator {
    static func injectDependencies(for viewController: DishesViewController) {
        let interactor = DishesInteractor()
        let worker = DishesWorker()
        let presenter = DishesPresenter()
        let router = DishesRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = viewController
        
        router.view = viewController
        router.dataStore = interactor
    }
}
