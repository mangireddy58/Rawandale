//
//  StatusProfileViewController.swift
//  Rawandale
//
//  Created by Sai on 09/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import Photos

class StatusProfileViewController: RootViewController, ClassForServerCommDelegate, UITextFieldDelegate {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var whatsYourLbl: UILabel!
    @IBOutlet weak var marialSegmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedHeightCOnstraint: NSLayoutConstraint!
    @IBOutlet weak var areYouFromLbl: UILabel!
    @IBOutlet weak var stateTxtFld: UITextField!
    @IBOutlet weak var cityTxtFld: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadInputViews ()
    }

    func loadInputViews () {
        self.stateTxtFld.delegate = self
        self.cityTxtFld.delegate = self
        self.segmentedHeightCOnstraint.constant = 50
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        
        print("user gender\(String(describing: objUniversalDataModel?.userGenderString))")
        if (objUniversalDataModel?.statusProfileDict["state"]as AnyObject) as? NSNull != NSNull() {
            if (objUniversalDataModel?.statusProfileDict["state"] as AnyObject).length() > 0 {
                stateTxtFld.text = objUniversalDataModel?.statusProfileDict["state"] as AnyObject as? String
            }
        }
        else {
            stateTxtFld.text = ""
        }
        if (objUniversalDataModel?.statusProfileDict["city"]as AnyObject) as? NSNull != NSNull() {
            if (objUniversalDataModel?.statusProfileDict["city"] as AnyObject).length() > 0 {
                cityTxtFld.text = objUniversalDataModel?.statusProfileDict["city"] as AnyObject as? String
            }
        }
        else {
            cityTxtFld.text = ""
        }
        if (objUniversalDataModel?.statusProfileDict["maritalStatus"]as AnyObject) as? NSNull != NSNull() {
            if (objUniversalDataModel?.statusProfileDict["maritalStatus"] as AnyObject).length() > 0 {
                let status = objUniversalDataModel?.statusProfileDict["maritalStatus"] as AnyObject as? String
                if status == "single" {
                    marialSegmentedControl.selectedSegmentIndex = 0
                }
                else {
                    marialSegmentedControl.selectedSegmentIndex = 1
                }
            }
        }
        else {
            marialSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        }
    }
    
    // MARK:- Back
    @IBAction func backButtonPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    // MARK:- Save button Pressed
    @IBAction func saveButtonPressed(_ sender: Any) {
        if self.stateTxtFld.text?.characters.count == 0 {
            self.stateTxtFld .becomeFirstResponder()
        }
        else if self.cityTxtFld.text?.characters.count == 0 {
            self.cityTxtFld.becomeFirstResponder()
        }
        else {
            var marialStatusString = ""
            if marialSegmentedControl.selectedSegmentIndex == 0 {
                marialStatusString = "single"
            }
            else {
                marialStatusString = "married"
            }
//            {"user": {"userId": 22,"email": "aartivihire1008@gmail.com"},"userProfile": {"firstName": "aarti111","lastName": "vihire11","dob":"1993-08-11","contacts": "9960792634","sex": "female","maritalStatus": "single","profilePic": "testpic11","city": "pune1","state":"mh11"}}
            
            let updateProfileParams = String(format:Profile_update,"22", "aartivihire1008@gmail.com",(objUniversalDataModel?.userFirstNameString)!,(objUniversalDataModel?.userLastNameString)!,(objUniversalDataModel?.userDateOfBirthString)!, "9960792634", (objUniversalDataModel?.userGenderString)!, marialStatusString, "mangireddy", self.cityTxtFld.text!, self.stateTxtFld.text!)
            let serverCommObj = ServerCommunication()
            serverCommObj.delegate = self
            print("profile params",updateProfileParams)
            kServiceUrlTag = kSERVICE_URL_TAG.update_user_profile_url_tag.rawValue
            serverCommObj.sendHttpPostRequestWithParam(parameterString: updateProfileParams, serviceName: UPDATE_USER_PROFILE_DETAILS_URL)
        }
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        if responseDictionary["success"] as! Int == 0 {
            print(responseDictionary["message"] as! String)
        }
        else {
            print(responseDictionary["message"] as! String)
            self.fnForProfileViewController()
        }
    }
    func onServiceFailed() {
        print("Service failed")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
