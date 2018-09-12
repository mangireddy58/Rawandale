//
//  UserDataModel.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 27/12/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import CoreData

class UserDataModel: NSObject {
    
    static let userDataSharedInstance = UserDataModel()
    
    var mUserName:String!
    var mPassword:String!
    var mDeviceToken:Int!
    
    func saveData(username: String, password: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "UserPersonalData", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(username, forKey: "userName")
            newUser.setValue(password, forKey: "password")
            
            do {
                try context.save()
                print("Saved")
            } catch {
                print("Failed saving")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func getUserData() {
        // fetching the data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"UserPersonalData")
            request.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        UserDataModel.userDataSharedInstance.mUserName = result.value(forKey:"userName")as! String
//                        UserDataModel.userDataSharedInstance.mPassword = result.value(forKey:"password")as! String
                        print(mUserName)
//                        print(mPassword)
                    }
                }
            }
            catch {
                //
                print("Unable to fetch saved data")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func getSavedUserDict(userDataDict: NSDictionary) {
        mUserName = ""
        if (userDataDict["userName"]as AnyObject) as? NSNull != NSNull() {
            if (userDataDict["userName"] as AnyObject).length() > 0 {
                UserDataModel.userDataSharedInstance.mUserName = userDataDict["userName"] as AnyObject as? String
            }
        }
        
    }
    
    func saveUserName(userName:String) {
        mUserName = userName
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "UserPersonalData", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(userName, forKey: "userName")
            do {
                try context.save()
                print("Saved")
            } catch {
                print("Failed saving")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func getSavedUserName() {
        self.printData()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserPersonalData")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                print(result)
                for data in result as! [NSManagedObject] {
                    mUserName = data.value(forKey: "userName") as! String
                    mPassword =  data.value(forKey: "password") as! String
                    print(data.value(forKey: "deviceToken") as! Int)
                }
            } catch {
                print("Failed")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    // Printing the data
    func printData() {
        print(mUserName)
        print(mPassword)
    }

}
