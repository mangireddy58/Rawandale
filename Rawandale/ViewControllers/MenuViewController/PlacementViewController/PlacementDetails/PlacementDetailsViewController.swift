
//
//  PlacementDetailsViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 04/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class PlacementDetailsViewController: RootViewController, UITableViewDataSource, UITableViewDelegate, ClassForServerCommDelegate {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var placementDetailosTableView: UITableView!
    
    var mutableDataArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.placementDetailosTableView.bounces = false
        
        self.getPlacementSubCategory()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.placementDetailosTableView.estimatedRowHeight = 245
        self.placementDetailosTableView.rowHeight = UITableViewAutomaticDimension
    }
    //MARK:- Placement sub category
    func getPlacementSubCategory () {
//        print("placement id", self.objUniversalDataModel?.placementsubCatIdString as! String)
        self.showLoadingIndicator()
        let placementSubCategoryParams = String(format:GET_PLACEMENT_SUB_CATEGORY_PARAMS,(self.objUniversalDataModel?.placementsubCatIdString)!)
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("placement sub",placementSubCategoryParams)
        serverCommObj.sendHttpPostRequestWithParam(parameterString: placementSubCategoryParams, serviceName:GET_PLACEMENT_SUB_CATEGORY_URL)
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        let message = responseDictionary["success"] as! Int
        if message == 1 {
            self.mutableDataArray = responseDictionary["data"] as! NSArray
            print("placement ",self.mutableDataArray)
            self.placementDetailosTableView.dataSource = self
            self.placementDetailosTableView.delegate = self
            self.placementDetailosTableView.reloadData()
        }
        else {
            
        }
    }
    func onServiceFailed() {
        self.hideProgressIndicator()
        print("Service Failed")
    }
    // MARK:- Tableview datasource and delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mutableDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        tableView.register(UINib(nibName: "PlacementDetailsCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath) as! PlacementDetailsCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"profileImage") as? NSNull) != NSNull() {
            if ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"profileImage") as AnyObject).length() > 0 {
                cell.topicImageView.sd_setImage(with: URL(string: ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"profileImage")  as? String)!), placeholderImage: UIImage(named: "Default_user"))
            }
        }
        else {
            cell.topicImageView.sd_setImage(with: URL(string: "Default_user"), placeholderImage: UIImage(named: "Default_user"))
        }
        
        if ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"topicName") as? NSNull) != NSNull() {
            if ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"topicName") as AnyObject).length() > 0 {
                cell.descriptionNameLabel.text = (self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"topicName")  as? String
            }
        }
        else {
            cell.descriptionNameLabel.text = ""
        }
        
        if ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"shortDescription") as? NSNull) != NSNull() {
            if ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"shortDescription") as AnyObject).length() > 0 {
                cell.titleNameLabel.text = (self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"shortDescription")  as? String
            }
        }
        else {
            cell.titleNameLabel.text = ""
        }
        
        if ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"createdDate") as? NSNull) != NSNull() {
            if ((self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"createdDate") as AnyObject).length() > 0 {
                cell.dateLabel.text = self.changeDateFormatWithDate(dateString: (self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"createdDate")  as! String)
            }
        }
        else {
            cell.dateLabel.text = ""
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.objUniversalDataModel?.placementTipsAndTopicId = String(format: "%@", (self.mutableDataArray[indexPath.row] as AnyObject).value(forKey:"tipsAndTopicsId") as! CVarArg)
        self.fnForPlacementTipDetailsViewController()
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}
