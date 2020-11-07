//
//  nameTableViewCell.swift
//  SafeBites
//
//  Created by athena on 10/1/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class nameTableViewCell: UITableViewCell {

    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
