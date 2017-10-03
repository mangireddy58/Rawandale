//
//  SignUpViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 18/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class SignUpViewController: RootViewController,UITextFieldDelegate {
    
    var parentNavigationController : UINavigationController?
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var almostDoneLbl: UILabel!
    @IBOutlet weak var shareInfoLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailIdLbl: UILabel!
    @IBOutlet weak var mobileNumTxtFld: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInputViews()
    
    }
    func loadInputViews () {
        self.mobileNumTxtFld.tag = 1
        self.mobileNumTxtFld.delegate = self
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string:"Mobile Number", attributes: [NSParagraphStyleAttributeName: centeredParagraphStyle])
        self.mobileNumTxtFld.attributedPlaceholder = attributedPlaceholder
        
        let userDeafults = UserDefaults.standard
        userNameLbl.text = userDeafults.string(forKey: "FullName")
        emailIdLbl.text = userDeafults.string(forKey: "EMailId")
    }
    

    @IBAction func signUpBtnPressed(_ sender: Any) {
        if (self.mobileNumTxtFld.text!.characters.count) < 10 {
           self.mobileNumTxtFld.becomeFirstResponder()
        }
        else {
            print("success")
            self.fnForRevealViewController()
        }
    }
    @IBAction func backToLogin(_ sender: Any) {
        self.fnForRevealViewController()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.mobileNumTxtFld {
            if self.mobileNumTxtFld.text!.characters.count >= kMobileNumLength {
                self.mobileNumTxtFld.resignFirstResponder()
            }
        }
        return true
    }
    
    
    
    
}
    
    
    
    

