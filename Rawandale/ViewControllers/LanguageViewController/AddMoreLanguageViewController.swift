//
//  AddMoreLanguageViewController.swift
//  Rawandale
//
//  Created by Sai on 11/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import TextFieldEffects

class AddMoreLanguageViewController: RootViewController, ClassForServerCommDelegate {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var languageTxtFld: HoshiTextField!
    @IBOutlet weak var skillLevelTxtFld: HoshiTextField!
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
        self.showLoadingIndicator()
        let languageParams = String(format: "%@",GET_LANGUAGE_PARAMS)
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("lang",languageParams)
        kServiceUrlTag = kSERVICE_URL_TAG.get_languages_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: languageParams, serviceName: GET_LANGUAGES_URL)
        
        print("Delete lang",(self.objUniversalDataModel?.languageDeleteIdDict)!)
        if ((self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "userLangId")) != nil){
            self.addMoreBtn.setTitle("DELETE", for: .normal)
            self.languageTxtFld.text = (self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "language")as? String)
            var readStr:String = ""
            var writeStr:String = ""
            var speakStr:String = ""
            if ((self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "read")as? Int) != nil) {
                print("not empty")
                if (self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "read")as? Int) == 1 {
                    readStr = "READ"
                }
                else {
                    readStr = ""
                }
            }
            else {
                print("empty")
            }
            if ((self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "write")as? Int) != nil) {
                print("not empty")
                if (self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "write")as? Int) == 1 {
                    writeStr = readStr + ",WRITE"
                    
                }
                else {
                    writeStr = ""
                }
            }
            else {
                print("empty")
            }
            if ((self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "speak")as? Int) != nil) {
                print("not empty")
                if (self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "speak")as? Int) == 1 {
                    speakStr = writeStr + ",SPEAK"
                }
                else {
                    speakStr = ""
                }
            }
            else {
                print("empty")
            }
            self.skillLevelTxtFld.text = speakStr;
        }
        else {
            self.addMoreBtn.setTitle("ADD MORE", for: .normal)
        }
    }
    //MARK:- Server communication
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        switch kServiceUrlTag {
        case kSERVICE_URL_TAG.get_languages_url_tag.rawValue:
            if responseDictionary["success"] as! Int == 1 {
                let languageArray = (responseDictionary["data"] as! NSArray)
                print("Language array\(languageArray)")
                let languageNameArray = languageArray.value(forKey: "langName") as! NSArray
                print("Languagename array\(languageNameArray)")
            }
            else {
                print(responseDictionary["success"]as! String)
            }
            break
        case kSERVICE_URL_TAG.add_languages_url_tag.rawValue:
            print(responseDictionary["message"]as! String)
            if responseDictionary["success"] as! Int == 0 {
                print(responseDictionary["message"]as! String)
            }
            else {
                print(responseDictionary["message"]as! String)
                self.fnForAchivementViewController()
            }
            
            break
        case kSERVICE_URL_TAG.add_more_languages_url_tag.rawValue:
            print(responseDictionary["message"]as! String)
            if responseDictionary["success"] as! Int == 0 {
                print(responseDictionary["message"]as! String)
            }
            else {
                print(responseDictionary["message"]as! String)
                self.fnForAchivementViewController()
            }
            break
        case kSERVICE_URL_TAG.delete_language_url_tag.rawValue:
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
        self.hideProgressIndicator()
        print("Service failed")
    }
    //MARK:- Save lang
    @IBAction func saveBtnPressed(_ sender: Any) {
        // here we need to add langid as selected language id
        let addMoreProjectParams = String(format:UPDATE_LANGUAGES_PARAMS,self.languageTxtFld.text!,self.skillLevelTxtFld.text!, "22")
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("Save params",addMoreProjectParams)
        kServiceUrlTag = kSERVICE_URL_TAG.add_languages_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: addMoreProjectParams,serviceName: UPDATE_LANGUAGES_URL)
    }
    //MARK:- Add more lang
    @IBAction func addMoreBtnPressed(_ sender: Any) {
        if self.addMoreBtn.titleLabel?.text == "DELETE" {
            let deleteLangParams = String(format:DELETE_LANGUAGE_PARAMS,self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "userLangId") as! CVarArg)
            let serverCommObj = ServerCommunication()
            serverCommObj.delegate = self
            print("Delete lang params",deleteLangParams)
            kServiceUrlTag = kSERVICE_URL_TAG.delete_language_url_tag.rawValue
            serverCommObj.sendHttpPostRequestWithParam(parameterString: deleteLangParams,serviceName: DELETE_LANGUAGE_URL)
        }
        else {
            // Update
            let addMoreLangParams = String(format:EDIT_LANGUAGE_PARAMS,(self.objUniversalDataModel?.languageDeleteIdDict.value(forKey: "userLangId")) as! String, "22", self.languageTxtFld.text!,self.skillLevelTxtFld.text!)
            let serverCommObj = ServerCommunication()
            serverCommObj.delegate = self
            print("Add more lang params",addMoreLangParams)
            kServiceUrlTag = kSERVICE_URL_TAG.add_more_languages_url_tag.rawValue
            serverCommObj.sendHttpPostRequestWithParam(parameterString: addMoreLangParams,serviceName: EDIT_LANGUAGE_URL)
        }
    }
    
    //MARK:- Back
    @IBAction func backBtnPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    
}
