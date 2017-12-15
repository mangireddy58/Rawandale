//
//  ProjectCustomCell.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 08/12/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class ProjectCustomCell: UITableViewCell {

    @IBOutlet weak var projectNameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
