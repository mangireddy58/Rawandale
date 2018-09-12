//
//  MenuViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 19/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit


class MenuViewController: RootViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    var menuNameArray:[String] =  []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.bounces = false
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        menuNameArray = ["DashBoard", "DigitalCV", "Drives", "Placement Prep", "Announcement", "About Us", "Logout"];
        
        let userDeafults = UserDefaults.standard
        userNameLbl.text = userDeafults.string(forKey: "FullName")
        userEmailLbl.text = userDeafults.string(forKey: "EMailId")
//        let data = UserDefaults.standard.object(forKey: "SavedMyImage")
//        profilePicImageView.image = UIImage(data: data as! Data)
        if (UserDefaults.standard.object(forKey: "SavedMyImage") as? NSNull) != NSNull() {
            if (UserDefaults.standard.object(forKey: "SavedMyImage") as AnyObject).length() > 0 {
                profilePicImageView.sd_setImage(with: URL(string: (UserDefaults.standard.object(forKey: "SavedMyImage")  as? String)!), placeholderImage: UIImage(named: "Default_user"))
            }
        }
        else {
            profilePicImageView.sd_setImage(with: URL(string: "Default_user"), placeholderImage: UIImage(named: "Default_user"))
        }
        // Circle with normal
        self.profilePicImageView.layer.borderWidth = 02;
        self.profilePicImageView.layer.borderColor = UIColor.lightGray.cgColor
        self.profilePicImageView.layer.cornerRadius = self.profilePicImageView.frame.size.width / 2
        self.profilePicImageView.clipsToBounds = true
        
        // Circle using UIImageview
        //        self.profilePicImageView.cropAsCircleWithBorder(borderColor: UIColor.white, borderWidth: 2)
        
        // Circle with UIImage
        //        let img = profilePicImageView.image
        //        profilePicImageView.image = img?.cropWithColorAndBorderWidth(borderColor:.black , borderWidth: 10)
        
        
        
        
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "Dashboard", for: indexPath)
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "DigitalCV", for: indexPath)
            
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "Drives", for: indexPath)
            
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "PlacementPrep", for: indexPath)
            
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "Announcement", for: indexPath)
            
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "AboutUs", for: indexPath)
            
        case 6:
            cell = tableView.dequeueReusableCell(withIdentifier: "Logout", for: indexPath)
            
        default: break
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        switch (indexPath as NSIndexPath).row {
        case 6:
            break
        default: break
        }
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NSLog("Segue: %@ - identifier: %@", segue.description, segue.identifier!)
    }
    
}


