//
//  DigitalCVViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 19/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class DigitalCVViewController: RootViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ClassForServerCommDelegate {
    
    

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuBtnPressed: UIButton!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var digitalCVTableView: UITableView!
    @IBOutlet weak var CVCollectionView: UICollectionView!
    
    var cvDataDict = NSDictionary()
    var titleDataArray:[String] = ["PERSONAL DETAILS","ACADEMICS","ACHIEVEMENTS", "PROJECTS", "LANGUAGES", "SKILLS", "HOBBIES", "SOCIAL CONNECT", "CAREER OBJECTIVE"]
    var imageDataArray:[String] = ["personalinfo","acadmics","achivement", "projects", "languages", "skills", "hobbies", "socialconnect", "careerguidence"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtnPressed.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for:.touchUpInside)
        
        self.digitalCVTableView.bounces = false
        CVCollectionView.dataSource = self
        CVCollectionView.delegate = self
        CVCollectionView.bounces = false
        
        self.getCVdata()
        
    }

    func getCVdata () {
        self.showLoadingIndicator()
        // Get user details
        let cvParams = String(format:GET_CV_DATA_PARAMS, "22")
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("cv details",cvParams)
        kServiceUrlTag = kSERVICE_URL_TAG.get_cv_data_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: cvParams, serviceName: GET_CV_DATA_URL)
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        let success = responseDictionary["success"] as! Int
        if success == 1 {
            self.cvDataDict = responseDictionary["data"] as! NSDictionary
            self.digitalCVTableView.dataSource = self
            self.digitalCVTableView.delegate = self
            self.digitalCVTableView.reloadData()
        }
        else {
            print(responseDictionary["message"]!)
        }
    }
    func onServiceFailed() {
        print("Service failed")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleDataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CVCollectionView.dequeueReusableCell(withReuseIdentifier: "CVCollectionCell", for: indexPath) as! DigitalCollectionCVCell
        cell.colorLabel.backgroundColor = UIColor.red
        return cell
    }
    //MARK:- Tableview Datasource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cvDataDict.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item % 2 == 0 {
            let leftIdentifier = "LeftCell"
            tableView.register(UINib(nibName: "DigitalLeftCell", bundle: nil), forCellReuseIdentifier:leftIdentifier)
            let leftCell = tableView.dequeueReusableCell(withIdentifier: leftIdentifier) as! DigitalLeftCell
            leftCell.cvImageView.layer.cornerRadius = leftCell.cvImageView.frame.size.width / 2
            leftCell.cvImageView.clipsToBounds = true
            leftCell.titleLabel.text = titleDataArray[indexPath.row]
            leftCell.cvImageView.image = UIImage(named: imageDataArray[indexPath.row])
            if indexPath.row == 0 {
                if self.cvDataDict["userProfile"] as! Int == 1 {
                    leftCell.statusLabel.text = "Completed"
                    leftCell.statusLabel.textColor = UIColor.green
                }
                else {
                    leftCell.statusLabel.text = "Pending"
                    leftCell.statusLabel.textColor = UIColor.red
                }
            }
            if indexPath.row == 2 {
                if self.cvDataDict["achievements"] as! Int == 1 {
                    leftCell.statusLabel.text = "Completed"
                    leftCell.statusLabel.textColor = UIColor.green
                }
                else {
                    leftCell.statusLabel.text = "Pending"
                    leftCell.statusLabel.textColor = UIColor.red
                }
            }
            if indexPath.row == 4 {
                if self.cvDataDict["languages"] as! Int == 1 {
                    leftCell.statusLabel.text = "Completed"
                    leftCell.statusLabel.textColor = UIColor.green
                }
                else {
                    leftCell.statusLabel.text = "Pending"
                    leftCell.statusLabel.textColor = UIColor.red
                }
            }
            if indexPath.row == 6 {
                if self.cvDataDict["interests"] as! Int == 1 {
                    leftCell.statusLabel.text = "Completed"
                    leftCell.statusLabel.textColor = UIColor.green
                }
                else {
                    leftCell.statusLabel.text = "Pending"
                    leftCell.statusLabel.textColor = UIColor.red
                }
            }
            if indexPath.row == 8 {
                if self.cvDataDict["careerObjective"] as! Int == 1 {
                    leftCell.statusLabel.text = "Completed"
                    leftCell.statusLabel.textColor = UIColor.green
                }
                else {
                    leftCell.statusLabel.text = "Pending"
                    leftCell.statusLabel.textColor = UIColor.red
                }
            }
            return leftCell
        }
        else {
            let rightIdentifier = "RightCell"
            tableView.register(UINib(nibName: "DigitalRightCell", bundle: nil), forCellReuseIdentifier:rightIdentifier)
            let rightCell = tableView.dequeueReusableCell(withIdentifier: rightIdentifier) as! DigitalRightCell
            rightCell.cvImageView.layer.cornerRadius = rightCell.cvImageView.frame.size.width / 2
            rightCell.cvImageView.clipsToBounds = true
            rightCell.titleNameLabel.text = titleDataArray[indexPath.row]
            rightCell.cvImageView.image = UIImage(named: imageDataArray[indexPath.row])
            if indexPath.row == 1 {
                if self.cvDataDict["academic"] as! Int == 1 {
                    rightCell.statusLabel.text = "Completed"
                    rightCell.statusLabel.textColor = UIColor.green
                }
                else {
                    rightCell.statusLabel.text = "Pending- Required for drive"
                    rightCell.statusLabel.textColor = UIColor.red
                }
            }
            if indexPath.row == 3 {
                if self.cvDataDict["projects"] as! Int == 1 {
                    rightCell.statusLabel.text = "Completed"
                    rightCell.statusLabel.textColor = UIColor.green
                }
                else {
                    rightCell.statusLabel.text = "Pending"
                    rightCell.statusLabel.textColor = UIColor.red
                }
            }
            if indexPath.row == 5 {
                if self.cvDataDict["skills"] as! Int == 1 {
                    rightCell.statusLabel.text = "Completed"
                    rightCell.statusLabel.textColor = UIColor.green
                }
                else {
                    rightCell.statusLabel.text = "Pending"
                    rightCell.statusLabel.textColor = UIColor.red
                }
            }
            if indexPath.row == 7 {
                if self.cvDataDict["social"] as! Int == 1 {
                    rightCell.statusLabel.text = "Completed"
                    rightCell.statusLabel.textColor = UIColor.green
                }
                else {
                    rightCell.statusLabel.text = "Pending"
                    rightCell.statusLabel.textColor = UIColor.red
                }
            }
            return rightCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.fnForProfileViewController()
        }
        else if indexPath.item == 1 {
            print("Academics")
        }
        else if indexPath.item == 2 {
            print("Achivements")
            if self.cvDataDict["achievements"] as! Int == 1 {
                self.fnForAchivementViewController()
            }
            else {
                self.fnForAddAchivementViewController()
            }
        }
        else if indexPath.item == 3 {
            print("Projects")
            if self.cvDataDict["projects"] as! Int == 1 {
                self.fnForProjectsViewController()
            }
            else {
                self.fnForAddProjectsViewController()
            }
        }
        else if indexPath.item == 4 {
            print("Languages")
            if self.cvDataDict["languages"] as! Int == 1 {
                self.fnForLanguageViewController()
            }
            else {
                self.fnForAddLanguageViewController()
            }
        }
        else if indexPath.item == 5 {
            print("Skills")
            self.fnForSkillsViewController()
        }
        else if indexPath.item == 6 {
            print("Hobbies")
        }
        else if indexPath.item == 7 {
            print("Social connect")
        }
        else if indexPath.item == 8 {
            print("Career objective")
        }
    }
    
    @IBAction func savePdfButtonPressed(_ sender: Any) {
        
    }
}
