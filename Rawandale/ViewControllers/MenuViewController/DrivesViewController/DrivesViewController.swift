//
//  DrivesViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 20/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import PageMenu

class DrivesViewController: RootViewController, CAPSPageMenuDelegate {
    
    var pageMenu : CAPSPageMenu?
    var parameters: [CAPSPageMenuOption] = []
    @IBOutlet weak var menuBtnPressed: UIButton!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtnPressed.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var controllerArray : [UIViewController] = []
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let ourDrives  = storyBoard.instantiateViewController(withIdentifier: "OurDrivesViewController") as! OurDrivesViewController
        ourDrives.title = "OUR DRIVES"
        ourDrives.parentNavigationController = self.navigationController
        controllerArray.append(ourDrives)
        
        let otherDrives  = storyBoard.instantiateViewController(withIdentifier: "OtherDrivesViewController") as! OtherDrivesViewController
        otherDrives.title = "OTHER DRIVES"
        otherDrives.parentNavigationController = self.navigationController
        controllerArray.append(otherDrives)
        
        
        switch VIEWHEIGHT {
        case 568.0:
            parameters = [
                .scrollMenuBackgroundColor(UIColor.white),
                .viewBackgroundColor(UIColor.clear),
                .selectionIndicatorColor(UIColor(red: 41.0/255.0, green: 161.0/255.0, blue: 209.0/255.0, alpha: 1.0)),
                .bottomMenuHairlineColor(UIColor.white),
                .selectedMenuItemLabelColor(UIColor(red: 41.0/255.0, green: 161.0/255.0, blue: 209.0/255.0, alpha: 1.0)),
                .menuItemSeparatorColor(UIColor.white),
                .unselectedMenuItemLabelColor(UIColor.lightGray),
                .useMenuLikeSegmentedControl(true),
                .menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
                .menuHeight(40.0),
                .titleTextSizeBasedOnMenuItemWidth(true),
                .centerMenuItems(true)
            ]
        case 667.0:
            parameters = [
                .scrollMenuBackgroundColor(UIColor.white),
                .viewBackgroundColor(UIColor.clear),
                .selectionIndicatorColor(UIColor(red: 41.0/255.0, green: 161.0/255.0, blue: 209.0/255.0, alpha: 1.0)),
                .bottomMenuHairlineColor(UIColor.white),
                .selectedMenuItemLabelColor(UIColor(red: 41.0/255.0, green: 161.0/255.0, blue: 209.0/255.0, alpha: 1.0)),
                .menuItemSeparatorColor(UIColor.white),
                .unselectedMenuItemLabelColor(UIColor.lightGray),
                .useMenuLikeSegmentedControl(true),
                .menuItemFont(UIFont(name: "HelveticaNeue", size: 15.0)!),
                .menuHeight(50.0),
                .titleTextSizeBasedOnMenuItemWidth(true),
                .centerMenuItems(true)
            ]
        case 736.0:
            parameters = [
                .scrollMenuBackgroundColor(UIColor.white),
                .viewBackgroundColor(UIColor.clear),
                .selectionIndicatorColor(UIColor(red: 41.0/255.0, green: 161.0/255.0, blue: 209.0/255.0, alpha: 1.0)),
                .bottomMenuHairlineColor(UIColor.white),
                .selectedMenuItemLabelColor(UIColor(red: 41.0/255.0, green: 161.0/255.0, blue: 209.0/255.0, alpha: 1.0)),
                .menuItemSeparatorColor(UIColor.white),
                .unselectedMenuItemLabelColor(UIColor.lightGray),
                .useMenuLikeSegmentedControl(true),
                .menuItemFont(UIFont(name: "HelveticaNeue", size: 17.0)!),
                .menuHeight(60.0),
                .titleTextSizeBasedOnMenuItemWidth(true),
                .centerMenuItems(true)
            ]
        default:
            print("not an iPhone")
        }
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.contentView.frame.width, height: self.contentView.frame.height), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        self.addChildViewController(pageMenu!)
        self.contentView.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParentViewController: self)
    }
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        print("did move to page")
    }
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        print("will move to page")
    }
    

}
