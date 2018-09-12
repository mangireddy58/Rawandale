//
//  AnnouncementViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 20/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit


class AnnouncementViewController: RootViewController, UITableViewDataSource, UITableViewDelegate, ClassForServerCommDelegate {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var manuBtnPressed: UIButton!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var annoucementTableView: UITableView!
    var dataArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manuBtnPressed.addTarget(self.revealViewController(), action:#selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

        self.fnForNotification ()
        
    }
    func fnForNotification () {
        
        print(UserDataModel.userDataSharedInstance.mUserName)
       
        self.showLoadingIndicator()
        let announcementParams = String(format: "%@", GET_NOTIFICATION_PARAMS)
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("A Params",announcementParams)
        kServiceUrlTag = kSERVICE_URL_TAG.announcement_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: announcementParams, serviceName: GET_NOTIFICATION_URL)
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        if responseDictionary["success"] as! Int == 0 {
            print(responseDictionary["message"] as! String)
        }
        else {
            self.dataArray = (responseDictionary["data"] as! NSArray)
            self.annoucementTableView.dataSource = self
            self.annoucementTableView.delegate = self
            self.annoucementTableView .reloadData()
        }
    }
    func onServiceFailed() {
        self.hideProgressIndicator()
        print("Service failed")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.annoucementTableView.estimatedRowHeight = 80
        self.annoucementTableView.rowHeight = UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        tableView.register(UINib(nibName: "AnnouncementCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath) as! AnnouncementCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if (self.dataArray.value(forKey: "message")as AnyObject) as? NSNull != NSNull() {
            cell.announcementLabel.text! = (self.dataArray[indexPath.row] as AnyObject).value(forKey:"message")  as! String
        }else {
            cell.announcementLabel.text! = ""
        }
        if (self.dataArray.value(forKey: "createdDate")as AnyObject) as? NSNull != NSNull() {
            cell.dateLabel.text = self.changeDateFormatWithString(dateString:(self.dataArray[indexPath.row] as AnyObject).value(forKey: "createdDate") as! String)
        }else {
            cell.announcementLabel.text! = ""
        }
        
        return cell
    }
    
    
    
}
