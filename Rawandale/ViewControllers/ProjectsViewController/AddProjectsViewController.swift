//
//  AddProjectsViewController.swift
//  Rawandale
//
//  Created by Sai on 09/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import TextFieldEffects

class AddProjectsViewController: RootViewController, ClassForServerCommDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var projectsLbl: UILabel!
    @IBOutlet weak var titleNameTxtFld: HoshiTextField!
    @IBOutlet weak var teamSizeTxtFld: HoshiTextField!
    @IBOutlet weak var roleTxtFld: HoshiTextField!
    @IBOutlet weak var yearTxtFld: HoshiTextField!
    @IBOutlet weak var descriptionTxtFld: HoshiTextField!
    @IBOutlet weak var addMoreBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadInputViews()
    }
    func loadInputViews () {
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        titleNameTxtFld.delegate = self
        teamSizeTxtFld.delegate = self
        roleTxtFld.delegate = self
        yearTxtFld.delegate = self
        descriptionTxtFld.delegate = self
        teamSizeTxtFld.keyboardType = .numberPad
        yearTxtFld.keyboardType = .numberPad
        
        print("Team size",(self.objUniversalDataModel?.projectDeleteIdDict)!)
        if ((self.objUniversalDataModel?.projectDeleteIdDict.value(forKey: "projectId")) != nil){
            self.addMoreBtn.setTitle("DELETE", for: .normal)
            self.titleNameTxtFld.text = (self.objUniversalDataModel?.projectDeleteIdDict.value(forKey: "projectName")as? String)
            self.yearTxtFld.text = (self.objUniversalDataModel?.projectDeleteIdDict.value(forKey: "projectYear")as? String)
            self.teamSizeTxtFld.text = "\((self.objUniversalDataModel?.projectDeleteIdDict.value(forKey:"teamsize"))!)"
            self.roleTxtFld.text = (self.objUniversalDataModel?.projectDeleteIdDict.value(forKey: "role")as? String)
            self.descriptionTxtFld.text = (self.objUniversalDataModel?.projectDeleteIdDict.value(forKey: "description")as? String)
        }
        else {
            self.addMoreBtn.setTitle("ADD MORE", for: .normal)
        }
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
     switch sender.tag {
     case 1 :
        if self.titleNameTxtFld.text?.characters.count == 0 || self.teamSizeTxtFld.text?.characters.count == 0 || self.roleTxtFld.text?.characters.count == 0 || self.yearTxtFld.text?.characters.count == 0 || self.descriptionTxtFld.text?.characters.count == 0 {
            print("Enter all the fields")
        }
        else {
            if self.addMoreBtn.titleLabel?.text == "DELETE" {
                let deleteProjectParams = String(format:DELETE_PROJECT_PARAMS,self.objUniversalDataModel?.projectDeleteIdDict.value(forKey: "projectId") as! CVarArg)
                let serverCommObj = ServerCommunication()
                serverCommObj.delegate = self
                print("Delete pro params",deleteProjectParams)
                kServiceUrlTag = kSERVICE_URL_TAG.delete_projects_url_tag.rawValue
                serverCommObj.sendHttpPostRequestWithParam(parameterString: deleteProjectParams,serviceName: DELETE_PROJECT_URL)
            }
            else {
                let addMoreProjectParams = String(format:ADD_PROJECT_PARAMS,self.titleNameTxtFld.text!,self.teamSizeTxtFld.text!, self.roleTxtFld.text!,self.yearTxtFld.text!,self.descriptionTxtFld.text!,"22")
                let serverCommObj = ServerCommunication()
                serverCommObj.delegate = self
                print("Add more params",addMoreProjectParams)
                kServiceUrlTag = kSERVICE_URL_TAG.add_more_projects_url_tag.rawValue
                serverCommObj.sendHttpPostRequestWithParam(parameterString: addMoreProjectParams,serviceName: ADD_PROJECT_URL)
            }
        }
        break
            
     case 2 :
        if self.titleNameTxtFld.text?.characters.count == 0 || self.teamSizeTxtFld.text?.characters.count == 0 || self.roleTxtFld.text?.characters.count == 0 || self.yearTxtFld.text?.characters.count == 0 || self.descriptionTxtFld.text?.characters.count == 0 {
            print("Enter all the fields")
        }
        else {
            let addProjectParams = String(format:ADD_PROJECT_PARAMS,self.titleNameTxtFld.text!,self.teamSizeTxtFld.text!, self.roleTxtFld.text!,self.yearTxtFld.text!,self.descriptionTxtFld.text!,"22")
            let serverCommObj = ServerCommunication()
            serverCommObj.delegate = self
            print("Add pro params",addProjectParams)
            kServiceUrlTag = kSERVICE_URL_TAG.add_projects_url_tag.rawValue
            serverCommObj.sendHttpPostRequestWithParam(parameterString: addProjectParams,serviceName: ADD_PROJECT_URL)
        }
        break
        
            default:
            break
        }
    }
    // MARK:- Server delegates
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        switch kServiceUrlTag {
        case kSERVICE_URL_TAG.add_projects_url_tag.rawValue:
            if responseDictionary["success"] as! Int == 0 {
                print(responseDictionary["message"] as! String)
                self.fnForProjectsViewController()
            }
            else {
                print(responseDictionary["message"]as! String)
//                self.achivementTxtFld.text = ""
//                self.yearTxtFld.text = ""
            }
            break
        case kSERVICE_URL_TAG.add_more_projects_url_tag.rawValue:
            print(responseDictionary["message"]as! String)
            if responseDictionary["success"] as! Int == 0 {
                print(responseDictionary["message"]as! String)
            }
            else {
                print(responseDictionary["message"]as! String)
                self.fnForAchivementViewController()
            }
            break
        case kSERVICE_URL_TAG.delete_projects_url_tag.rawValue:
            print(responseDictionary["message"]as! String)
            if responseDictionary["success"] as! Int == 0 {
                print(responseDictionary["message"]as! String)
            }
            else {
                print(responseDictionary["message"]as! String)
                self.fnForProjectsViewController()
            }
            break
        default:
            break
            
        }
    }
    
    func onServiceFailed() {
        print("Service failed")
        self.hideProgressIndicator()
    }
}
