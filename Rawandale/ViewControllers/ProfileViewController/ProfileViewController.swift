//
//  ProfileViewController.swift
//  Rawandale
//
//  Created by Sai on 06/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit


class ProfileViewController: RootViewController, ClassForServerCommDelegate {
    
    @IBOutlet weak var menuHeaderViewLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userMobileNumberLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var marialStatusLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var personalBtn: UIButton!
    @IBOutlet weak var statusBtn: UIButton!
    
    var userDataDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadInputViews()
        
    }

    func loadInputViews () {
        
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        
        self.userImageView.layer.borderWidth = 02;
        self.userImageView.layer.borderColor = UIColor.lightGray.cgColor
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
        self.userImageView.clipsToBounds = true
        self.personalBtn.tag = 1
        self.statusBtn.tag = 2
        
        let userDeafults = UserDefaults.standard
        userNameLabel.text = userDeafults.string(forKey: "FullName")
        userEmailLabel.text = userDeafults.string(forKey: "EMailId")
        if (UserDefaults.standard.object(forKey: "SavedMyImage") as? NSNull) != NSNull() {
            if (UserDefaults.standard.object(forKey: "SavedMyImage") as AnyObject).length() > 0 {
                userImageView.sd_setImage(with: URL(string: (UserDefaults.standard.object(forKey: "SavedMyImage")  as? String)!), placeholderImage: UIImage(named: "Default_user"))
            }
        }
        else {
            userImageView.sd_setImage(with: URL(string: "Default_user"), placeholderImage: UIImage(named: "Default_user"))
        }
        // Get user details
        let resendOtpParams = String(format:GET_USER_PROFILE_DETAILS_PARAMS, "22")
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("",resendOtpParams)
        kServiceUrlTag = kSERVICE_URL_TAG.get_user_profile_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: resendOtpParams, serviceName: GET_USER_PROFILE_DETAILS_URL)
        
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        switch kServiceUrlTag {
        case kSERVICE_URL_TAG.get_user_profile_url_tag.rawValue:
            let message = responseDictionary["success"] as! Int
            if message == 1 {
                self.userDataDict = responseDictionary["data"] as! NSDictionary
                let userPersonalDict = self.userDataDict["user"] as! NSDictionary
                let userProfileDict = self.userDataDict["userProfile"] as! NSDictionary
                print("personal",userPersonalDict)
                print(userProfileDict)
                objUniversalDataModel?.statusProfileDict = userProfileDict
                objUniversalDataModel?.personalProfileDict = userPersonalDict
//                print("data model dict\(String(describing: objUniversalDataModel?.statusProfileDict))")
                if (userPersonalDict["userName"]as AnyObject) as? NSNull != NSNull() {
                    if (userPersonalDict["userName"] as AnyObject).length() > 0 {
                        userNameLabel.text = userPersonalDict["userName"] as AnyObject as? String
                    }
                }
                else {
                    userNameLabel.text = ""
                }
                if (userPersonalDict["email"]as AnyObject) as? NSNull != NSNull() {
                    if (userPersonalDict["email"] as AnyObject).length() > 0 {
                        userEmailLabel.text = userPersonalDict["email"] as AnyObject as? String
                    }
                }
                else {
                    userEmailLabel.text = ""
                }
                if (userProfileDict["contacts"]as AnyObject) as? NSNull != NSNull() {
                    if (userProfileDict["contacts"] as AnyObject).length() > 0 {
                        userMobileNumberLabel.text = userProfileDict["contacts"] as AnyObject as? String
                    }
                }
                else {
                    userMobileNumberLabel.text = ""
                }
                if (userProfileDict["sex"]as AnyObject) as? NSNull != NSNull() {
                    if (userProfileDict["sex"] as AnyObject).length() > 0 {
                        userGenderLabel.text = userProfileDict["sex"] as AnyObject as? String
                    }
                }
                else {
                    userGenderLabel.text = ""
                }
                if (userProfileDict["maritalStatus"]as AnyObject) as? NSNull != NSNull() {
                    if (userProfileDict["maritalStatus"] as AnyObject).length() > 0 {
                        marialStatusLabel.text = userProfileDict["maritalStatus"] as AnyObject as? String
                    }
                }
                else {
                    marialStatusLabel.text = ""
                }
                if (userProfileDict["state"]as AnyObject) as? NSNull != NSNull() {
                    if (userProfileDict["state"] as AnyObject).length() > 0 {
                        stateLabel.text = userProfileDict["state"] as AnyObject as? String
                    }
                }
                else {
                    stateLabel.text = ""
                }
                if (userProfileDict["city"]as AnyObject) as? NSNull != NSNull() {
                    if (userProfileDict["city"] as AnyObject).length() > 0 {
                        cityNameLabel.text = userProfileDict["city"] as AnyObject as? String
                    }
                }
                else {
                    cityNameLabel.text = ""
                }
            }
            else {
                print(responseDictionary["message"]as! String)
            }
            break
        case kSERVICE_URL_TAG.update_user_profile_url_tag.rawValue:
            
            break
        default:
            break
        }
    }
    
    func onServiceFailed() {
        print("Service failed")
    }
    
    @IBAction func personalEditButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.fnForPersonalViewController()
            break
        case 2:
            self.fnForStatusProfileViewController()
            break
        
        default:
            print("Others")
            break
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }

    }

}
