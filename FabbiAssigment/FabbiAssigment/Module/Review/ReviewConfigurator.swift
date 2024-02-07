//
//  ReviewConfigurator.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

final class ReviewConfigurator {
    static func injectDependencies(for viewController: ReviewViewController) {
        let interactor = ReviewInteractor()
        let worker = ReviewWorker()
        let presenter = ReviewPresenter()
        let router = ReviewRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = viewController
        
        router.view = viewController
        router.dataStore = interactor
    }
}
