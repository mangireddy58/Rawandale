//
//  ProjectsViewController.swift
//  Rawandale
//
//  Created by Sai on 09/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class ProjectsViewController: RootViewController, ClassForServerCommDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var yourProjectsLbl: UILabel!
    @IBOutlet weak var projectsTblView: UITableView!
    @IBOutlet weak var addMoreProjectsBtn: UIButton!
    var projectsResArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadInputViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.projectsTblView.estimatedRowHeight = 120
        self.projectsTblView.rowHeight = UITableViewAutomaticDimension
    }
    func loadInputViews() {
        self.projectsTblView.bounces = false
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        self.showLoadingIndicator()
        // Get pro details
        let projectParams = String(format:GET_PROJECT_PARAMS, "22")
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("pro params",projectParams)
        kServiceUrlTag = kSERVICE_URL_TAG.get_projects_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: projectParams
            , serviceName: GET_PROJECT_URL)
    }
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        if responseDictionary["success"] as! Int == 0 {
            print(responseDictionary["message"] as! String)
        }
        else {
            self.projectsResArray = responseDictionary["data"] as! NSArray
            self.projectsTblView.dataSource = self
            self.projectsTblView.delegate = self
            self.projectsTblView.reloadData()
        }
    }
    func onServiceFailed() {
        self.hideProgressIndicator()
        print("Service failed")
    }
    
    //MARK:- TableViewDatasource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsResArray.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        projectsTblView.register(UINib(nibName: "ProjectCustomCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        let cell = projectsTblView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath) as! ProjectCustomCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if (projectsResArray.value(forKey: "projectName")as AnyObject) as? NSNull != NSNull() {
            cell.projectNameLbl.text = (projectsResArray .object(at: indexPath.row) as AnyObject).value(forKey: "projectName") as? String
        }
        if (projectsResArray.value(forKey: "projectYear")as AnyObject) as? NSNull != NSNull() {
            cell.yearLbl.text = String(format: "DESCRIPTION IN MORE DETAIL       %@", ((projectsResArray[indexPath.row] as AnyObject).value(forKey: "projectYear") as? String!)!)
        }
        if (projectsResArray.value(forKey: "description")as AnyObject) as? NSNull != NSNull() {
            cell.descriptionLbl.text = (projectsResArray .object(at: indexPath.row) as AnyObject).value(forKey: "description") as? String
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.objUniversalDataModel?.projectDeleteIdDict = projectsResArray[indexPath.row] as! NSDictionary
        self.fnForAddProjectsViewController()
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    @IBAction func addMoreProjectsBtnPressed(_ sender: Any) {
        if projectsResArray.count == 5 {
            print("Not possible more than by 5")
        }
        else {
             self.fnForAddProjectsViewController()
        }
    }
    

}
