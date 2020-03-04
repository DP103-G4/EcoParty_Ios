//
//  UserTableViewCell.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/2.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userOptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
