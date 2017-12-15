//
//  OurDrivesViewController.swift
//  SwiftP2
//
//  Created by Rushikesh Kulkarni on 03/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class OurDrivesViewController: RootViewController, ClassForServerCommDelegate {
    
    var parentNavigationController : UINavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadInputViews()
    }
    
    func loadInputViews () {
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        self.showLoadingIndicator()
        // Get our drives details
        let projectParams = String(format:GET_ELIGIBILITY_DRIVES_PARAMS, "22")
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("our drives ",projectParams)
        kServiceUrlTag = kSERVICE_URL_TAG.get_eligibility_drives_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: projectParams
            , serviceName: GET_ELIGIBILITY_DRIVES_URL)
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        if responseDictionary["success"] as! Int == 0 {
            print(responseDictionary["message"] as! String)
        }
        else {
//            self.projectsResArray = responseDictionary["data"] as! NSArray
//            self.projectsTblView.dataSource = self
//            self.projectsTblView.delegate = self
//            self.projectsTblView.reloadData()
        }
    }
    func onServiceFailed() {
        self.hideProgressIndicator()
        print("Service failed")
    }
    
    @IBAction func action(_ sender: Any) {
    }

}
