//
//  PlacementCustomCell.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 04/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class PlacementCustomCell: UITableViewCell {

    @IBOutlet weak var topicsNameLabel: UILabel!
    @IBOutlet weak var radioBtnImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        radioBtnImageView.layer.borderWidth = 2
        radioBtnImageView.layer.borderColor = UIColor.white.cgColor
        radioBtnImageView.layer.cornerRadius = self.radioBtnImageView.frame.size.width / 2
        radioBtnImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
