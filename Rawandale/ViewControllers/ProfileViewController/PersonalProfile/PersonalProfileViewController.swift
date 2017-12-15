//
//  PersonalProfileViewController.swift
//  Rawandale
//
//  Created by Sai on 09/10/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class PersonalProfileViewController: RootViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var tellUsLbl: UILabel!
    @IBOutlet weak var userPicImageVIew: UIImageView!
    @IBOutlet weak var firstNameTxtFld: UITextField!
    @IBOutlet weak var lastNameTxtFld: UITextField!
    @IBOutlet weak var dateOfBirthTxtFld: UITextField!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextBtn: UIButton!
    
    var datePicker = MIDatePickerDemo.getFromNib()
    var dateFormatter = DateFormatter()
    var imagePickerController : UIImagePickerController!
    var pickedImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadinputView ()
    }

    func loadinputView () {
        setupDatePicker()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.firstNameTxtFld.delegate = self
        self.lastNameTxtFld.delegate = self
        self.dateOfBirthTxtFld.delegate = self
        self.segmentHeightConstraint.constant = 50
        self.userPicImageVIew.layer.borderColor = UIColor.lightGray.cgColor
        self.userPicImageVIew.layer.borderColor = UIColor.lightGray.cgColor
        self.userPicImageVIew.layer.cornerRadius = self.userPicImageVIew.frame.size.width / 2
        self.userPicImageVIew.clipsToBounds = true
        
        if !(objUniversalDataModel != nil) {
            objUniversalDataModel = UniversalDataModel.getUniversalDataModel()
        }
        let imageTapGesture = UITapGestureRecognizer(target: self, action:#selector(imageTapped))
        userPicImageVIew.addGestureRecognizer(imageTapGesture)
        userPicImageVIew.isUserInteractionEnabled = true
        userPicImageVIew.contentMode = .scaleAspectFill
        
//        print("data model dict\(String(describing: objUniversalDataModel?.statusProfileDict))")
        if (objUniversalDataModel?.statusProfileDict["firstName"]as AnyObject) as? NSNull != NSNull() {
            if (objUniversalDataModel?.statusProfileDict["firstName"] as AnyObject).length() > 0 {
                firstNameTxtFld.text = objUniversalDataModel?.statusProfileDict["firstName"] as AnyObject as? String
            }
        }
        else {
            firstNameTxtFld.text = ""
        }
        if (objUniversalDataModel?.statusProfileDict["lastName"]as AnyObject) as? NSNull != NSNull() {
            if (objUniversalDataModel?.statusProfileDict["lastName"] as AnyObject).length() > 0 {
                lastNameTxtFld.text = objUniversalDataModel?.statusProfileDict["lastName"] as AnyObject as? String
            }
        }
        else {
            lastNameTxtFld.text = ""
        }
        if (objUniversalDataModel?.statusProfileDict["dob"]as AnyObject) as? NSNull != NSNull() {
            if (objUniversalDataModel?.statusProfileDict["dob"] as AnyObject).length() > 0 {
                dateOfBirthTxtFld.text = objUniversalDataModel?.statusProfileDict["dob"] as AnyObject as? String
            }
        }
        else {
            dateOfBirthTxtFld.text = ""
        }
        if (objUniversalDataModel?.statusProfileDict["sex"]as AnyObject) as? NSNull != NSNull() {
            if (objUniversalDataModel?.statusProfileDict["sex"] as AnyObject).length() > 0 {
                let status = objUniversalDataModel?.statusProfileDict["sex"] as AnyObject as? String
                if status == "female" {
                    genderSegmentedControl.selectedSegmentIndex = 1
                }
                else {
                    genderSegmentedControl.selectedSegmentIndex = 0
                }
            }
        }
        else {
            genderSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        }
        
        if (UserDefaults.standard.object(forKey: "SavedMyImage") as? NSNull) != NSNull() {
            if (UserDefaults.standard.object(forKey: "SavedMyImage") as AnyObject).length() > 0 {
                userPicImageVIew.sd_setImage(with: URL(string: (UserDefaults.standard.object(forKey: "SavedMyImage")  as? String)!), placeholderImage: UIImage(named: "Default_user"))
            }
        }
        else {
            userPicImageVIew.sd_setImage(with: URL(string: "Default_user"), placeholderImage: UIImage(named: "Default_user"))
        }
    }
    // TapGesture Method
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.pickMedia()
    }
    // MARK: - Custom Methods -
    func pickMedia(){
        let actionSheet = UIAlertController.init(title: "Please choose a source type", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: "Take Photo", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.presentImagePickerFor(sourceType: .camera) // pick from camera
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Choose Gallery", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.presentImagePickerFor(sourceType: .photoLibrary)  // click with library
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePickerFor(sourceType : UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            // init and present picker
            imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
            imagePickerController.mediaTypes = ["public.image"]
            imagePickerController.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            DispatchQueue.main.async {
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
        }
        else {
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        // dismiss on finished picking
        DispatchQueue.main.async{
            self.dismiss(animated: true, completion: nil)
        }
        if (info[UIImagePickerControllerMediaType] as? String) != nil {
            pickedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            self.userPicImageVIew.contentMode = .scaleAspectFit
            self.userPicImageVIew.image = pickedImage

        }
        else {
        }
    }
    // Mark:- Dob
    @IBAction func dobButtonPressed(_ sender: Any) {
         datePicker.show(inVC: self)
    }
    // MARK:- SetUp DatePicker
    private func setupDatePicker() {
        datePicker.delegate = self
        datePicker.config.startDate = NSDate()
        datePicker.config.animationDuration = 0.25
        datePicker.config.cancelButtonTitle = "Cancel"
        datePicker.config.confirmButtonTitle = "Confirm"
        datePicker.config.contentBackgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        datePicker.config.headerBackgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        datePicker.config.confirmButtonColor = UIColor(red: 32/255.0, green: 146/255.0, blue: 227/255.0, alpha: 1)
        datePicker.config.cancelButtonColor = UIColor(red: 32/255.0, green: 146/255.0, blue: 227/255.0, alpha: 1)
    }
    // MARK:- Next
    @IBAction func nextBtnPressed(_ sender: Any) {
        objUniversalDataModel?.userFirstNameString = self.firstNameTxtFld.text!
        objUniversalDataModel?.userLastNameString = self.lastNameTxtFld.text!
        objUniversalDataModel?.userDateOfBirthString = self.dateOfBirthTxtFld.text!
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            objUniversalDataModel?.userGenderString = "male"
        }
        else {
            objUniversalDataModel?.userGenderString = "female"
        }
        self.fnForStatusProfileViewController()
    }
    //MARK:- Cancel
    @IBAction func backButtonPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    // MARK:- Textfield delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
    }
    
}

extension PersonalProfileViewController: MIDatePickerDelegate {
    func miDatePicker(amDatePicker: MIDatePickerDemo, didSelect date: NSDate) {
        dateOfBirthTxtFld.text = dateFormatter.string(from: date as Date)
        print("dob", dateOfBirthTxtFld.text! )
    }
    func miDatePickerDidCancelSelection(amDatePicker: MIDatePickerDemo) {
        // NOP
    }
}
