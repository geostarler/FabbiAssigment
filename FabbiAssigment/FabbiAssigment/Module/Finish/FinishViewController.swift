//
//  FinishViewController.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import UIKit

protocol PresenterToViewFinishProtocol: AnyObject {}

final class FinishViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var bookButton: UIButton!
    // MARK: - Public Variable
    
    var interactor: ViewToInteractorFinishProtocol?
    var router: (ViewToRouterFinishProtocol & DataPassingFinishProtocol)?
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        FinishConfigurator.injectDependencies(for: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        FinishConfigurator.injectDependencies(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func applyLocalization() {}
    
    @IBAction func bookClicked(_ sender: Any) {
        goToCategory()
    }
}

// MARK: - IBAction

private extension FinishViewController {
    func goToCategory() {
        router?.goToCategory()
    }
}

// MARK: - PresenterToView

extension FinishViewController: PresenterToViewFinishProtocol {}

// MARK: - Private

private extension FinishViewController {}
