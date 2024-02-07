//
//  DetailCell.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var inforLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(name: String, info: String) {
        nameLabel.text = name
        inforLabel.text = info
    }
    
}
