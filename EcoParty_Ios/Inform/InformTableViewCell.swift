//
//  InformTableViewCell.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/21.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class InformTableViewCell: UITableViewCell {

    @IBOutlet weak var informContentLabel: UILabel!
    @IBOutlet weak var informTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
