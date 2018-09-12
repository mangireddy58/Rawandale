
//
//  PlacementViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 20/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class PlacementViewController: RootViewController, UITableViewDataSource, UITableViewDelegate, ClassForServerCommDelegate {
    

    @IBOutlet weak var menuBtnPressed: UIButton!
    @IBOutlet weak var placementTableView: UITableView!
    
    var topicNamesArray = NSArray()
    var subCategoryIdArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtnPressed.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.placementTableView.bounces = false
        self.getPlacementCategory()
    }
    
    // MARK:- Placement Category
    func getPlacementCategory () {
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        self.showLoadingIndicator()
        let placementParams = String(format: "%@",GET_PLACEMENT_CATEGORY_PARAMS)
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        serverCommObj.sendHttpPostRequestWithParam(parameterString: placementParams, serviceName: GET_PLACEMENT_CATEGORY_URL)
    }
    
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        let message = responseDictionary["success"] as! Int
        if message == 1 {
            self.topicNamesArray = (responseDictionary["data"] as! NSArray)
            print("res", self.topicNamesArray)
            self.placementTableView.dataSource = self
            self.placementTableView.delegate = self
            self.placementTableView.reloadData()
        }
        else {
            
        }
        
    }
    func onServiceFailed() {
        self.hideProgressIndicator()
        print("Service Failed")
    }
    // MARK:- Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicNamesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        placementTableView.register(UINib(nibName: "PlacementCustomCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        let cell = placementTableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath) as! PlacementCustomCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if (self.topicNamesArray.value(forKey: "subCatName")as AnyObject) as? NSNull != NSNull() {
            cell.topicsNameLabel.text = (self.topicNamesArray .object(at: indexPath.row) as AnyObject).value(forKey: "subCatName") as? String
        }
        else {
            cell.topicsNameLabel.text = ""
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Subcatgeory id is \((self.topicNamesArray .object(at: indexPath.row) as AnyObject).value(forKey: "subCategoryId")as! CVarArg)")
        self.objUniversalDataModel?.placementsubCatIdString = "\((self.topicNamesArray .object(at: indexPath.row) as AnyObject).value(forKey: "subCategoryId")as! CVarArg)"
        self.fnForPlacementDetailsViewController()
    }

}
