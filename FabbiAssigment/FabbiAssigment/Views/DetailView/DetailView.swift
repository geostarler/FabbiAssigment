//
//  DetailView.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//

import UIKit

class DetailView: BaseView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    func updateText(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
}
