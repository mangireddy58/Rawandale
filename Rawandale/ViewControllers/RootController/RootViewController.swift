//
//  RootViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 18/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import SystemConfiguration
import SDWebImage


class RootViewController: UIViewController {
    
    var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var kServiceUrlTag:Int = 100
    var objUniversalDataModel: UniversalDataModel?
    let sdLoader = SDLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
    }
    // MARK:- Login
    func fnForLoginViewController () {
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    // MARK:- Signup
    func fnForSignUpViewController () {
        let signUp = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    // MARK:- OTP
    func fnForOTPViewController () {
        let otpVC = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    // MARK:- Revealcontroller
    func fnForRevealViewController () {
        let revealVC = storyBoard.instantiateViewController(withIdentifier: "RevealViewController") as! RevealViewController
        self.navigationController?.pushViewController(revealVC, animated: true)
    }
    // MARK:-DashBoard
    func fnForDashBoardViewController () {
        let dashBoard = storyBoard.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(dashBoard, animated: true)
    }
    // MARK:- Placement Prep
    func fnForPlacementViewController () {
        let placement = storyBoard.instantiateViewController(withIdentifier: "PlacementViewController") as! PlacementViewController
        self.navigationController?.pushViewController(placement, animated: true)
    }
    // MARK:- Placement Details
    func fnForPlacementDetailsViewController () {
        let placementDetails = storyBoard.instantiateViewController(withIdentifier: "PlacementDetailsViewController") as! PlacementDetailsViewController
        self.navigationController?.pushViewController(placementDetails, animated: true)
    }
    // MARK:- Placement tip Details
    func fnForPlacementTipDetailsViewController () {
        let placementTipDetails = storyBoard.instantiateViewController(withIdentifier: "PlacementTipViewController") as! PlacementTipViewController
        self.navigationController?.pushViewController(placementTipDetails, animated: true)
    }
    // MARK:- Profile
    func fnForProfileViewController () {
        let profile = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profile, animated: true)
    }
    func fnForPersonalViewController () {
        let personalProfile = storyBoard.instantiateViewController(withIdentifier: "PersonalProfileViewController") as! PersonalProfileViewController
        self.navigationController?.pushViewController(personalProfile, animated: true)
    }
    func fnForStatusProfileViewController () {
        let statusProfile = storyBoard.instantiateViewController(withIdentifier: "StatusProfileViewController") as! StatusProfileViewController
        self.navigationController?.pushViewController(statusProfile, animated: true)
    }
    // MARK:- Digital VC
    func fnForDigitalCVViewController () {
        let digitalCV = storyBoard.instantiateViewController(withIdentifier: "DigitalCVViewController") as! DigitalCVViewController
        self.navigationController?.pushViewController(digitalCV, animated: true)
    }
    // MARK:- Achivement VC
    func fnForAchivementViewController () {
        let achivementVC = storyBoard.instantiateViewController(withIdentifier: "AchivementViewController") as! AchivementViewController
        self.navigationController?.pushViewController(achivementVC, animated: true)
    }
    // MARK:- Add achivement
    func fnForAddAchivementViewController () {
        let addAchivementVC = storyBoard.instantiateViewController(withIdentifier: "AddAchivementViewController") as! AddAchivementViewController
        self.navigationController?.pushViewController(addAchivementVC, animated: true)
    }
    // MARK:- Projects
    func fnForProjectsViewController () {
        let projectsVC = storyBoard.instantiateViewController(withIdentifier: "ProjectsViewController") as! ProjectsViewController
        self.navigationController?.pushViewController(projectsVC, animated: true)
    }
    // MARK:- Add Projects
    func fnForAddProjectsViewController () {
        let addProjectsVC = storyBoard.instantiateViewController(withIdentifier: "AddProjectsViewController") as! AddProjectsViewController
        self.navigationController?.pushViewController(addProjectsVC, animated: true)
    }
    //MARK:- Language
    func fnForLanguageViewController () {
        let language = storyBoard.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        self.navigationController?.pushViewController(language, animated: true)
    }
    
    //MARK:- Add Languages
    func fnForAddLanguageViewController () {
        let language = storyBoard.instantiateViewController(withIdentifier: "AddMoreLanguageViewController") as! AddMoreLanguageViewController
        self.navigationController?.pushViewController(language, animated: true)
    }
    //MARK:- Skills
    func fnForSkillsViewController () {
        let skill = storyBoard.instantiateViewController(withIdentifier: "SkillsViewController") as! SkillsViewController
        self.navigationController?.pushViewController(skill, animated: true)
    }
    // MARK:- Internet Connection
    func isConnectedToNetwork() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags){
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    // MARK:- Dateformat
    func changeDateFormatWithString(dateString:String) -> String {
        let dateStr = dateString
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let yourDate = formatter.date(from: dateStr as String)
        formatter.dateFormat = "dd-MM-yyyy h:mm a"
        let finalStr = formatter.string(from: yourDate!)
        return finalStr as String
    }
    func changeDateFormatWithDate(dateString:String) -> String {
        let dateStr = dateString
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let yourDate = formatter.date(from: dateStr as String)
        formatter.dateFormat = "dd-MM-yyyy"
        let finalStr = formatter.string(from: yourDate!)
        return finalStr as String
    }
    // MARK:- Show Progress Indicator
    func showLoadingIndicator()-> Void {
        // For loader
        sdLoader.startAnimating(atView: self.view)
    }
    // MARK:- Hide Progress Indicator
    func hideProgressIndicator() {
        sdLoader.stopAnimation()
    }
    
}
