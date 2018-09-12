//
//  AchivementCustomCell.swift
//  Rawandale
//
//  Created by Sai on 09/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class AchivementCustomCell: UITableViewCell {

    @IBOutlet weak var achivementNameLbl: UILabel!
    @IBOutlet weak var achivementYearLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
