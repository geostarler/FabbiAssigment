//
//  AppButton.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//

import UIKit

@IBDesignable
class AppButton: UIButton {

    @IBInspectable var isColorButton: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius = 8
        self.tintColor = .white
        self.backgroundColor = isColorButton ? R.color.darkGreen() : .lightGray
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
}
