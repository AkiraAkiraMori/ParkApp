//
//  ParkInfoTableViewCell.swift
//  ParkApp
//
//  Created by ntt on 2017/09/13.
//  Copyright © 2017年 nttresonant. All rights reserved.
//

import UIKit

class ParkInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var contentTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
