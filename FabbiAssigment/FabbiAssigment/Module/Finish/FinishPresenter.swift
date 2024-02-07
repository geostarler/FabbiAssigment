//
//  FinishPresenter.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import Foundation

protocol InteractorToPresenterFinishProtocol {}

final class FinishPresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewFinishProtocol?
}

// MARK: - InteractorToPresenter

extension FinishPresenter: InteractorToPresenterFinishProtocol {}

// MARK: - Private

private extension FinishPresenter {}
