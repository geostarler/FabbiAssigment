//
//  DishesViewController.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import UIKit

protocol PresenterToViewDishesProtocol: AnyObject {
    func reloadTableViewData(with getDishViewModel: Dishes.Dishes.ViewModel)
    func showDishesErrorAlert()
    func showNoServingErrorAlert()
    func showTotalDishesErrorAlert()
}

final class DishesViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var dishesTableView: UITableView!
    @IBOutlet private weak var stepBarView: StepBarView!
    
    // MARK: - Public Variable
    
    var interactor: ViewToInteractorDishesProtocol?
    var router: (ViewToRouterDishesProtocol & DataPassingDishesProtocol)?
    
    // MARK: - Private Variable
    
    private let setupViewModel: SetupViewModel = SetupViewModel(step: 3, isShowLeftButton: true)
    private let numberOfSection = 2
    private let numberRowInSection1 = 1
    private var dishesData: [String?] = []
    private var selectedDishModel: [SelectedDishModel] = [SelectedDishModel()]
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        DishesConfigurator.injectDependencies(for: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        DishesConfigurator.injectDependencies(for: self)
    }
    
    override func setupView() {
        super.setupView()
        registerCell()
        stepBarView.setupViewForStep(step: setupViewModel.step)
        updateDishCellSuccess()
    }
}

// MARK: - IBAction

private extension DishesViewController {
    func addMoreRow() {
        if selectedDishModel.count < dishesData.count {
            selectedDishModel.append(SelectedDishModel())
            let indexPath = IndexPath(row: selectedDishModel.count - 1, section: 0)
            let indexPathToUpdate = IndexPath(row: 0, section: 1)
            dishesTableView.insertRows(at: [indexPath], with: .fade)
            dishesTableView.reloadRows(at: [indexPathToUpdate], with: .automatic)
        }
    }
    
    func deleteRow() {
        if selectedDishModel.count > 1 {
            selectedDishModel.removeLast()
            let indexPath = IndexPath(row: selectedDishModel.count, section: 0)
            let indexPathToUpdate = IndexPath(row: 0, section: 1)
            dishesTableView.deleteRows(at: [indexPath], with: .fade)
            dishesTableView.reloadRows(at: [indexPathToUpdate], with: .automatic)
        }
    }
    
    func goToReview() {
        if interactor?.canGoNext(selectDishModel: selectedDishModel) ?? false {
            interactor?.updateOrder(dishModel: selectedDishModel)
            router?.goToReview()
        } else {
            interactor?.handlerError(selectDishModel: selectedDishModel)
        }
    }
    
    func backToRestaurant() {
        router?.backToRestaurent()
    }
}

// MARK: - PresenterToView

extension DishesViewController: PresenterToViewDishesProtocol {
    func showDishesErrorAlert() {
        showErrorAlert(message: R.string.localizable.dishes_error())
    }
    
    func showNoServingErrorAlert() {
        showErrorAlert(message: R.string.localizable.no_servings_error())
    }
    
    func showTotalDishesErrorAlert() {
        showErrorAlert(message: R.string.localizable.total_dishes_error())
    }
    
    func reloadTableViewData(with getDishViewModel: Dishes.Dishes.ViewModel) {
        self.dishesData = getDishViewModel.dishes
        self.dishesTableView.reloadData()
    }
}

// MARK: - Private

private extension DishesViewController {
    func registerCell() {
        dishesTableView.register(SelectedDishCell.self)
        dishesTableView.register(ButtonCell.self)
    }
    
    func updateDishCellSuccess() {
        interactor?.reloadDishCell()
    }
}

// MARK: - UITableview
extension DishesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return numberRowInSection1
        }
        return selectedDishModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeue(SelectedDishCell.self, for: indexPath)
            cell.dishesData = self.dishesData
            cell.updateCell(model: selectedDishModel[indexPath.row])
            cell.onDidSaveModel = { [weak self] model in
                self?.selectedDishModel[indexPath.row] = model
            }
            return cell
        } else {
            let cell = tableView.dequeue(ButtonCell.self, for: indexPath)
            let isShowAddButton = selectedDishModel.count < dishesData.count
            let isShowDeleteButton = selectedDishModel.count > 1
            cell.buttonView.setUpButton(isShowLeftButton: true, isSubmitButton: false)
            cell.updateView(isShowAddButton: isShowAddButton, isShowDeleteButton: isShowDeleteButton)
            cell.onAddMoreCellClicked = { [weak self] in
                DispatchQueue.main.async {
                    self?.addMoreRow()
                }
            }
            cell.onDeleteCellClicked = { [weak self] in
                DispatchQueue.main.async {
                    self?.deleteRow()
                }
            }
            cell.buttonView.onLeftButtonClicked = { [weak self] in
                self?.backToRestaurant()
            }
            cell.buttonView.onRightButtonClicked = { [weak self] in
                self?.goToReview()
            }
            return cell
        }
    }
}

