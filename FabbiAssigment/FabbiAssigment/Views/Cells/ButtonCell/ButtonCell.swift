//
//  ButtonCell.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet private weak var addDishButton: UIButton!
    @IBOutlet private weak var deleteDishButton: UIButton!
    
    @IBOutlet weak var buttonView: ButtonView!
    
    var onAddMoreCellClicked: (() -> Void)?
    var onDeleteCellClicked: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addDishButton.setTitle("", for: .normal)
        deleteDishButton.setTitle("", for: .normal)
    }
    
    @IBAction func addMoreCellClicked(_ sender: Any) {
        onAddMoreCellClicked?()
    }
    
    @IBAction func deleteCellClicked(_ sender: Any) {
        onDeleteCellClicked?()
    }
    
    func updateView(isShowAddButton: Bool, isShowDeleteButton: Bool) {
        addDishButton.isHidden = !isShowAddButton
        deleteDishButton.isHidden = !isShowDeleteButton
    }
}
