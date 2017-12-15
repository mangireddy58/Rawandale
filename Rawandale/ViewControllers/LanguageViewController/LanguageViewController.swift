
//
//  LanguageViewController.swift
//  Rawandale
//
//  Created by Sai on 11/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit


class LanguageViewController: RootViewController, ClassForServerCommDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var languageTblView: UITableView!
    @IBOutlet weak var addMoreBtn: UIButton!
    var languagesResArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadInputViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.languageTblView.estimatedRowHeight = 44
        self.languageTblView.rowHeight = UITableViewAutomaticDimension
    }
    func loadInputViews() {
        self.languageTblView.bounces = false
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        self.showLoadingIndicator()
        // Get lang details
        let projectParams = String(format:GET_USER_LANGUAGES_PARAMS, "22")
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("lang params",projectParams)
        kServiceUrlTag = kSERVICE_URL_TAG.get_user_languages_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: projectParams
            , serviceName: GET_USER_LANGUAGES_URL)
    }
    //MARK:- Services delegate
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        if responseDictionary["success"] as! Int == 0 {
            print(responseDictionary["message"] as! String)
        }
        else {
            self.languagesResArray = responseDictionary["data"] as! NSArray
            self.languageTblView.dataSource = self
            self.languageTblView.delegate = self
            self.languageTblView.reloadData()
        }
    }
    func onServiceFailed() {
        self.hideProgressIndicator()
        print("Service failed")
    }
    
    //MARK:- TableViewDatasource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagesResArray.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
//        languageTblView.register(UINib(nibName: "LanguageCustomCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        let cell = languageTblView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath) as! LanguageCustomCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if (languagesResArray.value(forKey: "language")as AnyObject) as? NSNull != NSNull() {
            cell.languageNameLabel.text = (languagesResArray .object(at: indexPath.row) as AnyObject).value(forKey: "language") as? String
        }
        else {
            cell.languageNameLabel.text = ""
        }
        if (languagesResArray.value(forKey: "read")as AnyObject) as? NSNull != NSNull() {
            if ((languagesResArray[indexPath.row] as AnyObject).value(forKey: "read") as? Int!) == 1 {
                cell.readLabel.text = "R"
                cell.readLabel.backgroundColor = UIColor(red: 36.0/255.0, green: 142.0/255.0, blue: 186.0/255.0, alpha: 1.0)
            }
        }else {
            cell.readLabel.isHidden = true
        }
        
        if (languagesResArray.value(forKey: "write")as AnyObject) as? NSNull != NSNull() {
            if ((languagesResArray .object(at: indexPath.row) as AnyObject).value(forKey: "write") as? Int) == 1 {
                cell.writeLabel.text = "W"
                cell.writeLabel.backgroundColor = UIColor(red: 36.0/255.0, green: 142.0/255.0, blue: 186.0/255.0, alpha: 1.0)
            }
        }else {
            cell.writeLabel.isHidden = true
        }
        
        if (languagesResArray.value(forKey: "speak")as AnyObject) as? NSNull != NSNull() {
            if (languagesResArray .object(at: indexPath.row) as AnyObject).value(forKey: "speak") as? Int == 1 {
                cell.speakLabel.text = "S"
                cell.speakLabel.backgroundColor = UIColor(red: 36.0/255.0, green: 142.0/255.0, blue: 186.0/255.0, alpha: 1.0)
            }
        }else {
            cell.speakLabel.isHidden = true
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.objUniversalDataModel?.languageDeleteIdDict = languagesResArray[indexPath.row] as! NSDictionary
        self.fnForAddLanguageViewController()
    }
    
    //MARK:- Back
    @IBAction func backBtnPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    // MARK:- Add more
    @IBAction func addMoreBtnPressed(_ sender: Any) {
        self.fnForAddLanguageViewController()
    }

}
