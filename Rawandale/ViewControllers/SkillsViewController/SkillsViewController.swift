//
//  SkillsViewController.swift
//  Rawandale
//
//  Created by Sai on 11/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import TextFieldEffects

class SkillsViewController: RootViewController, ClassForServerCommDelegate {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var skillsTxtFld: HoshiTextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let skillsParams = String(format: "%@",GET_SKILLS_PARAMS)
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        kServiceUrlTag = kSERVICE_URL_TAG.get_skills_url_tag.rawValue
        print("",skillsParams)
        serverCommObj.sendPostParametersWithNSUrlSession(parameterString: skillsParams, serviceName: GET_SKILLS_URL)
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        switch kServiceUrlTag {
        case kSERVICE_URL_TAG.get_skills_url_tag.rawValue:
            print("Skills")
            let message = responseDictionary["success"] as! Int
            if message == 1 {
                let skillsArray = (responseDictionary["data"] as! NSArray)
                print("Skills array\(skillsArray)")
            }
            else {
                print(responseDictionary["success"] as! String)
                self.showUniversalAlert(title: "", message: responseDictionary["success"] as! String)
            }
            break
//        case kSERVICE_URL_TAG.get_languages_url_tag.rawValue:
//            print("language")
//            break
        default:
            break
            
        }
        
    }
    func onServiceFailed() {
        print("Service failed")
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        self.fnForDigitalCVViewController()
    }



}
