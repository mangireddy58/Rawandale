//
//  AchivementViewController.swift
//  Rawandale
//
//  Created by Sai on 09/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class AchivementViewController: RootViewController, UITableViewDataSource, UITableViewDelegate, ClassForServerCommDelegate {

    
    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var achivementsLbl: UILabel!
    @IBOutlet weak var achivementsTblView: UITableView!
    @IBOutlet weak var addMoreBtn: UIButton!
    var achivementsArray = NSArray()
    var achivementsResArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadInputViews()
    }
    func loadInputViews() {
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        self.achivementsTblView.bounces = false
        self.achivementsTblView.dataSource = self
        self.achivementsTblView.delegate = self
        
        self.getAchivements()
    }
    func getAchivements() {
        self.showLoadingIndicator()
        // Get user details
        let achivementParams = String(format:GET_ACHIVEMENTS_PARAMS, "22")
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("Ac params",achivementParams)
        kServiceUrlTag = kSERVICE_URL_TAG.get_achivements_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: achivementParams
            , serviceName: GET_ACHIVEMENTS_URL)
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        if responseDictionary["success"] as! Int == 0 {
            print(responseDictionary["message"] as! String)
        }
        else {
            self.achivementsResArray = responseDictionary["data"] as! NSArray
            self.achivementsTblView.dataSource = self
            self.achivementsTblView.delegate = self
            self.achivementsTblView.reloadData()
        }
    }
    func onServiceFailed() {
        print("Service failed")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.achivementsTblView.estimatedRowHeight = 70
        self.achivementsTblView.rowHeight = UITableViewAutomaticDimension
    }
    //MARK:- TableViewDatasource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achivementsResArray.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        achivementsTblView.register(UINib(nibName: "AchivementCustomCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        let cell = achivementsTblView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath) as! AchivementCustomCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if (achivementsResArray.value(forKey: "achivement")as AnyObject) as? NSNull != NSNull() {
            cell.achivementNameLbl.text = (achivementsResArray .object(at: indexPath.row) as AnyObject).value(forKey: "achivement") as? String
        }
        if (achivementsResArray.value(forKey: "achivementYear")as AnyObject) as? NSNull != NSNull() {
            cell.achivementYearLbl.text = String(format: "YEAR OF THE ACHIVEMENT %@", ((achivementsResArray[indexPath.row] as AnyObject).value(forKey: "achivementYear") as? String!)!)
        }
        
//        cell.achivementNameLbl.text = achivementsArray[indexPath.row] as? String
//        cell.achivementYearLbl.text = "YEAR OF THE ACHIVEMENT 2017"///String(format: "YEAR OF THE ACHIVEMENT %@", (achivementsArray[indexPath.row] as? String)!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let delete = achivementsResArray[indexPath.row] as! NSDictionary
        self.objUniversalDataModel?.achivementDeleteArray = achivementsResArray[indexPath.row] as! NSDictionary
        self.fnForAddAchivementViewController()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }

    }
    
    @IBAction func addMoreBtnPressed(_ sender: Any) {
        if self.achivementsResArray.count == 5 {
            print("Not possible to add more than 5")
        }
        else {
            self.objUniversalDataModel?.achivementDeleteArray = [:]
            self.fnForAddAchivementViewController()
        }
    }
}
