//
//  DashBoardViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 19/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import PageMenu
import ScrollableSegmentedControl

class DashBoardViewController: RootViewController {
    
    var pageMenu : CAPSPageMenu?
    var parameters: [CAPSPageMenuOption] = []
    @IBOutlet weak var menuHeaderView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuBtnPressed: UIButton!
    @IBOutlet weak var menuHeaderLbl: UILabel!
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        menuBtnPressed.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        
        let segmentedControlAppearance = ScrollableSegmentedControl.appearance()
        segmentedControlAppearance.segmentContentColor = UIColor.black
        segmentedControlAppearance.selectedSegmentContentColor = (UIColor(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0))
        segmentedControlAppearance.backgroundColor = UIColor.groupTableViewBackground
        
        segmentedControl.segmentStyle = .textOnly
        segmentedControl.insertSegment(withTitle: "HOME", image:#imageLiteral(resourceName: "insta"), at: 0)
        segmentedControl.insertSegment(withTitle: "BIG DATA", image: #imageLiteral(resourceName: "loginbutton_on"), at: 1)
        segmentedControl.insertSegment(withTitle: "ANDROID", image: #imageLiteral(resourceName: "google"), at: 2)
        segmentedControl.insertSegment(withTitle: "CLOUD COMPUTING", image: #imageLiteral(resourceName: "fb"), at: 3)
        segmentedControl.insertSegment(withTitle: "SAP", image: #imageLiteral(resourceName: "linkedin"), at: 4)
        
        segmentedControl.underlineSelected = true
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(DashBoardViewController.segmentSelected(sender:)), for: .valueChanged)
    }
    func segmentSelected(sender:ScrollableSegmentedControl) {
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
    }
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var controllerArray : [UIViewController] = []
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeVC.title = "HOME"
        homeVC.parentNavigationController = self.navigationController
        controllerArray.append(homeVC)
        
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.title = "BIG DATA"
        loginVC.parentNavigationController = self.navigationController
        controllerArray.append(loginVC)
        
        let regiVC = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        regiVC.title = "ANDROID"
        regiVC.parentNavigationController = self.navigationController
        controllerArray.append(regiVC)
        
        let collectionVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        collectionVC.title = "CLOUD COMPUTING"
        collectionVC.parentNavigationController = self.navigationController
        controllerArray.append(collectionVC)
        
        let sapVC = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        sapVC.title = "SAP"
        sapVC.parentNavigationController = self.navigationController
        controllerArray.append(sapVC)
        
        switch viewHeight {
        case 568.0:
            parameters = [
                .MenuItemSeparatorWidth(4.3),
                .ScrollMenuBackgroundColor(UIColor.white),//(red: 82.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
                .ViewBackgroundColor(UIColor.clear),//(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
                .SelectionIndicatorColor(UIColor(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .BottomMenuHairlineColor(UIColor.white),//(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .SelectedMenuItemLabelColor(UIColor(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .UnselectedMenuItemLabelColor(UIColor.black),
                .MenuItemSeparatorColor(UIColor.white),
                .UseMenuLikeSegmentedControl(true),
                .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
                .MenuHeight(40.0),
                .MenuItemWidthBasedOnTitleTextWidth(true),
                .CenterMenuItems(true)
            ]
        case 667.0:
            parameters = [
                .MenuItemSeparatorWidth(4.3),
                .ScrollMenuBackgroundColor(UIColor.white),
                .ViewBackgroundColor(UIColor.clear),//(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
                .SelectionIndicatorColor(UIColor(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .BottomMenuHairlineColor(UIColor.white),//(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .SelectedMenuItemLabelColor(UIColor(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .UnselectedMenuItemLabelColor(UIColor.black),
                .MenuItemSeparatorColor(UIColor.white),
                .UseMenuLikeSegmentedControl(true),
                .MenuItemFont(UIFont(name: "HelveticaNeue", size: 15.0)!),
                .MenuHeight(50.0),
                .MenuItemWidthBasedOnTitleTextWidth(true),
                .CenterMenuItems(true)
            ]
        case 736.0:
            parameters = [
                .MenuItemSeparatorWidth(4.3),
                .ScrollMenuBackgroundColor(UIColor.white),
                .ViewBackgroundColor(UIColor.clear),//(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
                .SelectionIndicatorColor(UIColor(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .BottomMenuHairlineColor(UIColor.white),//(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .SelectedMenuItemLabelColor(UIColor(red: 82.0/255.0, green: 174.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .UnselectedMenuItemLabelColor(UIColor.black),
                .MenuItemSeparatorColor(UIColor.white),
                .UseMenuLikeSegmentedControl(true),
                .MenuItemFont(UIFont(name: "HelveticaNeue", size: 17.0)!),
                .MenuHeight(50.0),
                .MenuItemWidth(200),
                //.MenuItemWidthBasedOnTitleTextWidth(true),
                .CenterMenuItems(true)
            ]
        default:
            print("not an iPhone")
            
        }
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.contentView.frame.width, height: self.contentView.frame.height), pageMenuOptions: parameters)
        self.addChildViewController(pageMenu!)
        self.contentView.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
        
    }*/
    
    
    
    
    
    
    
    
    
   

}
