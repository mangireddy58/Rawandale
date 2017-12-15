//
//  AddAchivementViewController.swift
//  Rawandale
//
//  Created by Sai on 09/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class AddAchivementViewController: RootViewController, ClassForServerCommDelegate, UITextFieldDelegate {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var achivementLbl: UILabel!
    @IBOutlet weak var achivementTxtFld: UITextField!
    @IBOutlet weak var yearTxtFld: UITextField!
    @IBOutlet weak var addMoreBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadInputViews()
    }
    func loadInputViews () {
        self.achivementTxtFld.delegate = self
        self.yearTxtFld.delegate = self
        self.yearTxtFld.keyboardType = .numberPad
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
//        let idis = (self.objUniversalDataModel?.achivementDeleteArray.value(forKey: "achivementId")) as! CVarArg
//        print("id is", idis)
        if ((self.objUniversalDataModel?.achivementDeleteArray.value(forKey: "achivementId")) != nil){
            print("data")
            self.addMoreBtn.setTitle("DELETE", for: .normal)
            self.achivementTxtFld.text = (self.objUniversalDataModel?.achivementDeleteArray.value(forKey: "achivement")as? String)
            self.yearTxtFld.text = (self.objUniversalDataModel?.achivementDeleteArray.value(forKey: "achivementYear")as? String)
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

    @IBAction func addMoreBtnPressed(_ sender: Any) {
        if self.achivementTxtFld.text?.characters.count == 0 {
            self.achivementTxtFld .becomeFirstResponder()
        }else if self.yearTxtFld.text?.characters.count == 0 {
            self.yearTxtFld .becomeFirstResponder()
        }
        else {
            if self.addMoreBtn.titleLabel?.text == "DELETE" {
                let deleteAchivements = String(format:DELETE_ACHIVEMENT_PARAMS,self.objUniversalDataModel?.achivementDeleteArray.value(forKey: "achivementId") as! CVarArg)
                let serverCommObj = ServerCommunication()
                serverCommObj.delegate = self
                print("Delete ac params",deleteAchivements)
                kServiceUrlTag = kSERVICE_URL_TAG.delete_achivement_url_tag.rawValue
                serverCommObj.sendHttpPostRequestWithParam(parameterString: deleteAchivements,serviceName: DELETE_ACHIVEMENT_URL)
            }
            else {
                let addAchivementParams = String(format:ADD_ACHIVEMENTS_PARAMS,self.achivementTxtFld.text!,self.yearTxtFld.text!, "22")
                let serverCommObj = ServerCommunication()
                serverCommObj.delegate = self
                print("Add ac params",addAchivementParams)
                kServiceUrlTag = kSERVICE_URL_TAG.add_achivement_url_tag.rawValue
                serverCommObj.sendHttpPostRequestWithParam(parameterString: addAchivementParams,serviceName: ADD_ACHIEVEMENTS_URL)
            }
        }
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        switch kServiceUrlTag {
        case kSERVICE_URL_TAG.add_achivement_url_tag.rawValue:
            if responseDictionary["success"] as! Int == 0 {
                print(responseDictionary["message"]as! String)
            }
            else {
                print(responseDictionary["message"]as! String)
                self.achivementTxtFld.text = ""
                self.yearTxtFld.text = ""
            }
            break
        case kSERVICE_URL_TAG.add_more_achivement_url_tag.rawValue:
                print(responseDictionary["message"]as! String)
                if responseDictionary["success"] as! Int == 0 {
                    print(responseDictionary["message"]as! String)
                }
                else {
                    print(responseDictionary["message"]as! String)
                    self.fnForAchivementViewController()
                }
            break
        case kSERVICE_URL_TAG.delete_achivement_url_tag.rawValue:
            print(responseDictionary["message"]as! String)
            if responseDictionary["success"] as! Int == 0 {
                print(responseDictionary["message"]as! String)
            }
            else {
                print(responseDictionary["message"]as! String)
                self.fnForAchivementViewController()
            }
            break
        default:
            break
            
        }
    }
    func onServiceFailed() {
        print("Service failed")
    }
    @IBAction func saveBtnPressed(_ sender: Any) {
        if self.achivementTxtFld.text?.characters.count == 0 {
            self.achivementTxtFld .becomeFirstResponder()
        }else if self.yearTxtFld.text?.characters.count == 0 {
            self.yearTxtFld .becomeFirstResponder()
        }
        else {
            let addAchivementParams = String(format:ADD_ACHIVEMENTS_PARAMS,self.achivementTxtFld.text!,self.yearTxtFld.text!, "22")
            let serverCommObj = ServerCommunication()
            serverCommObj.delegate = self
            print("Add ac params",addAchivementParams)
            kServiceUrlTag = kSERVICE_URL_TAG.add_more_achivement_url_tag.rawValue
            serverCommObj.sendHttpPostRequestWithParam(parameterString: addAchivementParams,serviceName: ADD_ACHIEVEMENTS_URL)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
