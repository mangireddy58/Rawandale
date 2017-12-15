//
//  DigitalRightCell.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 04/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class DigitalRightCell: UITableViewCell {

    @IBOutlet weak var cvImageView: UIImageView!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
