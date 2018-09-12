//
//  UniversalDataModel.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 06/12/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
private var sUniversalDataModel: UniversalDataModel? = nil


class UniversalDataModel: NSObject {
    
    var personalProfileDict = NSDictionary()
    var statusProfileDict = NSDictionary()
    var userFirstNameString:String = ""
    var userLastNameString:String = ""
    var userDateOfBirthString:String = ""
    var userProfileImageString:String = ""
    var userGenderString:String = ""
    var achivementDeleteArray = NSDictionary()
    var projectDeleteIdDict = NSDictionary()
    var languageDeleteIdDict = NSDictionary()
    var placementsubCatIdString:String = ""
    var placementTipsAndTopicId:String = ""
    var videoDataDict = NSDictionary()
    
    class func getUniversalDataModel() -> UniversalDataModel {
        if sUniversalDataModel == nil {
            sUniversalDataModel = UniversalDataModel()
        }
        return sUniversalDataModel!
    }

}
