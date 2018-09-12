//
//  LanguageCustomCell.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 11/12/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class LanguageCustomCell: UITableViewCell {

    @IBOutlet weak var languageNameLabel: UILabel!
    @IBOutlet weak var readLabel: UILabel!
    @IBOutlet weak var writeLabel: UILabel!
    @IBOutlet weak var speakLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        readLabel.layer.cornerRadius = readLabel.frame.width/2
        readLabel.layer.masksToBounds = true
        
        writeLabel.layer.cornerRadius = writeLabel.frame.width/2
        writeLabel.layer.masksToBounds = true
        
        speakLabel.layer.cornerRadius = speakLabel.frame.width/2
        speakLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
