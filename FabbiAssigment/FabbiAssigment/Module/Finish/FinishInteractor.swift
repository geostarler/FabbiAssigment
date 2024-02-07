//
//  FinishInteractor.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import Foundation

protocol ViewToInteractorFinishProtocol {}

protocol DataStoreFinishProtocol {}

final class FinishInteractor: DataStoreFinishProtocol {
    
    // MARK: - Public Variable
    
    var presenter: InteractorToPresenterFinishProtocol?
    var worker: InteractorToWorkerFinishProtocol?
    
    // MARK: - Private Variable
    
}

// MARK: - ViewToInteractor

extension FinishInteractor: ViewToInteractorFinishProtocol {}

// MARK: - Private

private extension FinishInteractor {}
