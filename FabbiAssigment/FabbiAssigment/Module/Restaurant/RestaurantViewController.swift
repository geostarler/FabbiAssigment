//
//  RestaurantViewController.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import UIKit

protocol PresenterToViewRestaurantProtocol: AnyObject {
    func getRestaurantData(restaurant: [String?])
    func showRestaurantErrorAlert()
}

final class RestaurantViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var stepBarView: StepBarView!
    @IBOutlet private weak var selectedRestaurantLabel: UILabel!
    @IBOutlet private weak var selectedRestaurantTextField: UITextField!
    @IBOutlet private weak var buttonView: ButtonView!
    
    // MARK: - Public Variable
    
    var interactor: ViewToInteractorRestaurantProtocol?
    var router: (ViewToRouterRestaurantProtocol & DataPassingRestaurantProtocol)?
    
    // MARK: - Private Variable
    
    private let setupViewModel: SetupViewModel = SetupViewModel(step: 2, isShowLeftButton: true)
    private var pickerView = UIPickerView()
    private let numberOfComponents = 1
    private var restaurantData: [String?] = []
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        RestaurantConfigurator.injectDependencies(for: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        RestaurantConfigurator.injectDependencies(for: self)
    }
    
    override func applyLocalization() {
        selectedRestaurantLabel.text = R.string.localizable.select_restaurant()
    }
    
    override func setupView() {
        super.setupView()
        createPickerView()
        handleButton()
        buttonView.setUpButton(isShowLeftButton: setupViewModel.isShowLeftButton)
        stepBarView.setupViewForStep(step: setupViewModel.step)
        interactor?.updateRestaurant()
    }
}

// MARK: - IBAction

private extension RestaurantViewController {
    func handleButton() {
        buttonView.onLeftButtonClicked = { [weak self] in
            self?.router?.backToCategory()
        }
        buttonView.onRightButtonClicked = { [weak self] in
            guard let self = self else {return}
            let restaurant = selectedRestaurantTextField.text
            let canGoNext = self.interactor?.checkRestaurantTextField(text: restaurant) ?? false
            if canGoNext {
                self.interactor?.updateOrder(restaurant: restaurant ?? "")
                self.router?.goToDished()
            } else {
                self.interactor?.handlerError(restaurant: restaurant)
            }
        }
    }
    
    @objc func doneButtonTapped() {
        if (selectedRestaurantTextField.text?.isEmpty ?? false) {
            selectedRestaurantTextField.text = restaurantData[0]
        }
        view.endEditing(true)
    }
}

// MARK: - PresenterToView

extension RestaurantViewController: PresenterToViewRestaurantProtocol {
    func showRestaurantErrorAlert() {
        showErrorAlert(message: R.string.localizable.restaurant_error())
    }
    
    func getRestaurantData(restaurant: [String?]) {
        restaurantData = restaurant
    }
}

// MARK: - Private

private extension RestaurantViewController {
    private func createPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        selectedRestaurantTextField.inputView = pickerView
        selectedRestaurantTextField.inputAccessoryView = toolbar
    }
}

// MARK: - UIPickerView, UITextField
extension RestaurantViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return numberOfComponents
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return restaurantData.count
    }

    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return restaurantData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRestaurantTextField.text = restaurantData[row]
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.reloadAllComponents()
    }
}
