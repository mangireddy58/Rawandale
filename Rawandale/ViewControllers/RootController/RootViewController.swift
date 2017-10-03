//
//  RootViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 18/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
