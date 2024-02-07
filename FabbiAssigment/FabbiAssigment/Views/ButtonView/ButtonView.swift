//
//  ButtonView.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//

import UIKit

@IBDesignable
class ButtonView: BaseView {

    @IBOutlet private weak var leftButton: AppButton!
    @IBOutlet private weak var rightButton: AppButton!
    
    var onLeftButtonClicked: (() -> Void)?
    var onRightButtonClicked: (() -> Void)?
    
    func setUpButton(isShowLeftButton: Bool = true, isSubmitButton: Bool = false) {
        let leftButtonText = R.string.localizable.previous_button()
        let rightButtonText = isSubmitButton ? R.string.localizable.submit_button() : R.string.localizable.next_button()
        rightButton.setTitle(rightButtonText,
                             for: .normal)
        leftButton.setTitle(leftButtonText,
                             for: .normal)
        leftButton.isHidden = !isShowLeftButton
        
    }
    
    @IBAction func leftButtonClicked(_ sender: Any) {
        onLeftButtonClicked?()
    }
    
    @IBAction func rightButtonClicked(_ sender: Any) {
        onRightButtonClicked?()
    }
}
