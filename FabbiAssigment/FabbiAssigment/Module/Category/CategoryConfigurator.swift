//
//  CategoryConfigurator.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//  
//

final class CategoryConfigurator {
    static func injectDependencies(for viewController: CategoryViewController) {
        let interactor = CategoryInteractor()
        let worker = CategoryWorker()
        let presenter = CategoryPresenter()
        let router = CategoryRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = viewController
        
        router.view = viewController
        router.dataStore = interactor
    }
}
