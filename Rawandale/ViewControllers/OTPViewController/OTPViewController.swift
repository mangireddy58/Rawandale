//
//  OTPViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 10/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class OTPViewController: RootViewController, UITextFieldDelegate, ClassForServerCommDelegate {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var oneTimePasswordLbl: UILabel!
    @IBOutlet weak var mobileNumLbl: UILabel!
    @IBOutlet weak var otpTxtFld: UITextField!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var otpBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInputViews()
    }
    func loadInputViews () {
        let tintedImage = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        backBtn.setImage(tintedImage, for: .normal)
        backBtn.tintColor = UIColor.lightGray
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    @IBAction func submitBtnPressed(_ sender: Any) {
        if (self.otpTxtFld.text!.characters.count) < 4 {
            self.otpTxtFld.becomeFirstResponder()
        }
        else {
            self.fnForRevealViewController()
            let userDefaults = UserDefaults.standard
            userDefaults.set("1", forKey: "isLoggedIn") 
            userDefaults.synchronize()
//            let otpParams = String(format:CHECK_OTP_PARAMS, "22",self.otpTxtFld.text!)
//            let serverCommObj = ServerCommunication()
//            serverCommObj.delegate = self
//            print("",otpParams)
//            kServiceUrlTag = kSERVICE_URL_TAG.check_otp_url_tag.rawValue
//            serverCommObj.sendHttpPostRequestWithParam(parameterString: otpParams, serviceName: CHECK_OTP_URL)
        }
    }
    
    //MARK:- Resend OTP
    @IBAction func resendOtpBtnPressed(_ sender: Any) {
//        let resendOtpParams = String(format:RESEND_OTP_PARAMS, "22")
//        let serverCommObj = ServerCommunication()
//        serverCommObj.delegate = self
//        print("",resendOtpParams)
//        kServiceUrlTag = kSERVICE_URL_TAG.resend_otp_url_tag.rawValue
//        serverCommObj.sendHttpPostRequestWithParam(parameterString: resendOtpParams, serviceName: RESEND_OTP_URL)
    }
    
    // MARK:- Service success method
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        switch kServiceUrlTag {
        case kSERVICE_URL_TAG.check_otp_url_tag.rawValue:
            let message = responseDictionary["message"] as! String
            if message == "Incorrect otp." {
                
            }
            else {
                print(message)
            }
            break
        case kSERVICE_URL_TAG.resend_otp_url_tag.rawValue:
            print("Otp resend")
            let message = responseDictionary["message"] as! String
            if message == "Otp sent." {
                
            }
            else {
                print(message)
            }
            break
        default:
            break
            
        }
    }
    func onServiceFailed() {
        print("Service failed")
    }
    //MARK:- Textfield delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.otpTxtFld {
            if self.otpTxtFld.text!.characters.count >= kOTPNumLength {
                self.otpTxtFld.resignFirstResponder()
            }
        }
        return true
    }
}
