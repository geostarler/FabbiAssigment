//
//  CategoryViewController.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//  
//

import UIKit

protocol PresenterToViewCategoryProtocol: AnyObject {
    func getMealData(meal: [String?])
    func showMealErrorAlert()
    func showNumberOfPeopleErrorAlert()
}

final class CategoryViewController: BaseViewController {
    // MARK: - IBOutlet
    
    @IBOutlet private weak var mealLabel: UILabel!
    @IBOutlet private weak var numberPeopleLabel: UILabel!
    @IBOutlet private weak var mealTextField: UITextField!
    @IBOutlet private weak var numberPeopleTextField: UITextField!
    @IBOutlet private weak var buttonView: ButtonView!
    @IBOutlet private weak var stepBarView: StepBarView!
    
    // MARK: - Public Variable
    
    var interactor: ViewToInteractorCategoryProtocol?
    var router: (ViewToRouterCategoryProtocol & DataPassingCategoryProtocol)?
    
    // MARK: - Private Variable
    
    private let setupViewModel: SetupViewModel = SetupViewModel(step: 1, isShowLeftButton: false)
    private var pickerView = UIPickerView()
    private let numberOfComponents = 1
    private var mealData: [String?] = []
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        CategoryConfigurator.injectDependencies(for: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CategoryConfigurator.injectDependencies(for: self)
    }
    
    override func applyLocalization() {
        mealLabel.text = R.string.localizable.select_meal()
        numberPeopleLabel.text = R.string.localizable.select_number_people()
    }
    
    override func setupView() {
        super.setupView()
        createPickerView()
        buttonView.setUpButton(isShowLeftButton: setupViewModel.isShowLeftButton)
        stepBarView.setupViewForStep(step: setupViewModel.step)
        handleButton()
        interactor?.updateMeal()
    }
}

// MARK: - IBAction

private extension CategoryViewController {
    func handleButton() {
        buttonView.onRightButtonClicked = { [weak self] in
            guard let self = self else {return}
            let meal = self.mealTextField.text
            let numberOfPeople = self.numberPeopleTextField.text
            let checkCanGoNext = self.interactor?.checkMealTextField(text: meal) ?? false &&
            self.interactor?.checkNumberOfPeopleTextField(text: numberOfPeople) ?? false
            if checkCanGoNext {
                self.interactor?.updateOrder(meal: self.mealTextField.text, numberOfPeople: Int(numberPeopleTextField.text ?? ""))
                self.router?.goToRestaurantVC()
            } else {
                self.interactor?.handlerError(meal: meal, numberOfPeople: numberOfPeople)
            }
        }
    }

    @objc func doneButtonTapped() {
        if (mealTextField.text?.isEmpty ?? false) {
            mealTextField.text = mealData[0]
        }
        view.endEditing(true)
    }
}

// MARK: - PresenterToView

extension CategoryViewController: PresenterToViewCategoryProtocol {
    func showMealErrorAlert() {
        showErrorAlert(message: R.string.localizable.meal_error())
    }
    
    func showNumberOfPeopleErrorAlert() {
        showErrorAlert(message: R.string.localizable.no_people_error())
    }
    
    func getMealData(meal: [String?]) {
        mealData = meal
    }
}

// MARK: - Private

private extension CategoryViewController {
    private func createPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        mealTextField.inputView = pickerView
        mealTextField.inputAccessoryView = toolbar
    }
}

// MARK: - UIPickerview, UITextfield

extension CategoryViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return numberOfComponents
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return mealData.count
    }

    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mealData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mealTextField.text = mealData[row]
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.reloadAllComponents()
    }
}
