//
//  AboutusViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 20/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import MessageUI

class AboutusViewController: RootViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var menuBtnPressed: UIButton!
    @IBOutlet weak var aboutUsMenuLbl: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuHeaderView: UIView!
    @IBOutlet weak var teamBtn: UIButton!
    @IBOutlet weak var websiteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtnPressed.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.shareBtn.layer.borderWidth = 2
        self.shareBtn.layer.borderColor = UIColor(red: 91/255.0, green: 179/255.0, blue: 94/255.0, alpha: 1.0).cgColor
        self.loadInputViews()
    }
    func loadInputViews () {
        self.shareBtn.titleLabel?.font = LFONT18
        self.aboutUsMenuLbl.font = LFONT18
        self.teamBtn.titleLabel?.font = LFONT18
        self.websiteBtn.titleLabel?.font = LFONT18
    }
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.mailButtonPressed()
            break
        case 2:
            self.websiteButtonPressed()
            break
        case 3:
            self.facebookButtonPressed()
            break
        case 4:
            self.twitterButtonPressed()
            break
        case 5:
            self.shareAppButtonPressed()
            break
        default:
            print("Others")
            break
        }
    }
    
    func mailButtonPressed () {
        let mailComposer = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposer, animated: true)
        }
        else {
            self.showSendEmailErrorAlert()
        }
    }
    
    func websiteButtonPressed () {
        if let url = NSURL(string: "http://www.rawandale.com") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    func facebookButtonPressed () {
        print("fb")
        if let url = NSURL(string: "http://www.facebook.com/ShitalkumarRawandale") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    func twitterButtonPressed () {
        if let url = NSURL(string: "https://mobile.twitter.com/s_rawandale") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    func shareAppButtonPressed () {
        print("share app")
        let userDeafults = UserDefaults.standard
        let userName = userDeafults.string(forKey: "FullName")
        let message = NSString(format:"has invited you to join Rawandale app. To find out more please visit ou App:")
        let activityController = UIActivityViewController(activityItems: [userName!,message], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        self.present(activityController, animated: true, completion: nil)
    }
    
    
    // MARK:- MFMailComposeViewControllerDelegate
    func configuredMailComposeViewController()-> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["rawandale.team@gmail.com"])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,error: Error?) {
        controller.dismiss(animated: true)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    func showSendEmailErrorAlert() {
        let mailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (alert) in
            
        }
        mailErrorAlert.addAction(okAction)
        self.present(mailErrorAlert, animated: true, completion: nil)
    }
    
    
    
    
    
    

}
