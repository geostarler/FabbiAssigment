//
//  FinishConfigurator.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

final class FinishConfigurator {
    static func injectDependencies(for viewController: FinishViewController) {
        let interactor = FinishInteractor()
        let worker = FinishWorker()
        let presenter = FinishPresenter()
        let router = FinishRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = viewController
        
        router.view = viewController
        router.dataStore = interactor
    }
}
