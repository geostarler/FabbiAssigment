//
//  SelectedDishCell.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//

import UIKit

class SelectedDishCell: UITableViewCell {
    
    @IBOutlet weak var dishLabel: UILabel!
    @IBOutlet weak var noServingLabel: UILabel!
    
    @IBOutlet weak var dishTextField: UITextField!
    @IBOutlet weak var noServingTextField: UITextField!
    
    private var pickerView = UIPickerView()
    private let numberOfComponents = 1
    
    var dishesData: [String?] = []
    var onDidSaveModel: ((SelectedDishModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dishTextField.text = ""
        noServingTextField.text = ""
    }
    
    private func setUpCell() {
        pickerView.delegate = self
        pickerView.dataSource = self
        createPickerView()
    }
    
    private func createPickerView() {
        dishTextField.delegate = self
        noServingTextField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        dishTextField.inputView = pickerView
        dishTextField.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        if (dishTextField.text?.isEmpty ?? false) {
            dishTextField.text = dishesData[0]
        }
        endEditing(true)
    }
    
    func updateCell(model: SelectedDishModel?) {
        dishTextField.text = model?.dish ?? ""
        noServingTextField.text = String(model?.noOfServing ?? 1)
    }
}

// MARK: - UIPickerView, UITextField
extension SelectedDishCell: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return numberOfComponents
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return dishesData.count
    }

    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dishesData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dishTextField.text = dishesData[row]
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.reloadAllComponents()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let model = SelectedDishModel(dish: dishTextField.text, noOfServing: Int(noServingTextField.text ?? "") ?? 1)
        onDidSaveModel?(model)
    }
}
