//
//  TextTableViewCell.swift
//  FriendZone
//
//  Created by Han Luong on 5/23/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func nameChanged(_ sender: UITextField) {
    }
    
}
