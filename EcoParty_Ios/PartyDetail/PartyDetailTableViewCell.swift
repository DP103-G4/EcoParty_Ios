//
//  PartyDetailTableViewCell.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/8.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class PartyDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var msgTimeLabel: UILabel!
    @IBOutlet weak var userMsgLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
