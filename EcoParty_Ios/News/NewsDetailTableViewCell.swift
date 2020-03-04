//
//  NewsDetailTableViewCell.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/2.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class NewsDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var newsContentTextView: UITextView!
    @IBOutlet weak var newsPostLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
