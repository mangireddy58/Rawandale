//
//  GlobalConstant.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 19/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import Foundation
import UIKit

var Bounds = UIScreen.main.bounds
var VIEWHEIGHT = Bounds.size.height
var VIEWWIDTH = Bounds.size.height

// #MARK:- Social
var GOOGLE_CLIENT_ID = "21960296358-7ppj8em7e6as2b33k4i9t4mbtkvhchi8.apps.googleusercontent.com"

// #MARK:-
let kMobileNumLength = 10
let kOTPNumLength = 4

// #MARK:- URL'S
// Development
//var BASE_URL = "http://52.66.129.114:9090/satori/"
// Production
var BASE_URL = "http://35.154.164.48/satori/"

var SOCIAL_URL = "userSocialLogin"
var CHECK_EMAIL_URL = "checkemail"
var CHECK_OTP_URL = "checkOtp"
var RESEND_OTP_URL = "resendotp"
var GET_NOTIFICATION_URL = "getnotifications"
var GET_LANGUAGES_URL = "getlanguages"
var GET_SKILLS_URL = "getskills"
var GET_STATE_URL = "getState"
var ADD_EDUCATION_DETAILS_URL = "addEduDetails"
var GET_EDUCATION_DETAILS_URL = "getedudetails"
var GET_EXTERNAL_DRIVES = "getexternaldrives"
var UPDATE_USER_PROFILE_DETAILS_URL = "updateUserProfileDetail"
var GET_USER_PROFILE_DETAILS_URL = "getUserProfileDetails"
var GET_CITY_LIST_URL = "getCity"
var GET_UNIVERSITIES_URL = "getUniversities"
var GET_COLLEGE_LIST_URL = "getCollege"
var GET_DEGREE_LIST_URL = "getDegree"
var GET_SPECIALIZATION_URL = "getSpecialzation"
var GET_DRIVE_DOCUMENT_URL = "getDriveDocument"
var GET_CITY_COLLEGE_LIST_URL = "getCityColleges"
var GET_UNIVERCITY_BY_STATE_URL = "getuniversitiesbystate"
var UPDATE_INTERESTS_URL = "updateinterests"
var GET_INTERESTS_URL = "getinterests"
var GET_SOCIAL_CONNECT_URL = "getsocailconnect"
var UPDATE_SOCIAL_CONNECT_URL = "updatesocialconnect"
var ADD_ACHIEVEMENTS_URL = "addachievements"
var GET_ACHIVEMENTS_URL = "getachievements"
var GET_USER_SKILLS_URL = "getuserskills"
var ADD_PROJECT_URL = "addproject"
var GET_PROJECT_URL = "getprojects"
var UPDATE_LANGUAGES_URL = "updatelanguages"
var GET_USER_LANGUAGES_URL = "getuserlanguages"
var GET_ELIGIBILITY_DRIVES_URL = "geteligibledrives"
var APPLY_FOR_DRIVE_URL = "applyfordrive"
var GET_APPLIED_DRIVES_URL = "getapplieddrives"
var GET_DRIVE_DETAILS_URL = "getdrivedetails"
var GET_NON_ELIGIBILITY_DRIVES_URL = "getnoneligibledrives"
var EDIT_PROJECT_URL = "editproject"
var DELETE_PROJECT_URL = "deleteproject"
var EDIT_LANGUAGE_URL = "editlanguage"
var DELETE_LANGUAGE_URL = "deletelanguage"
var EDIT_ACHIVEMENT_URL = "editachievement"
var DELETE_ACHIVEMENT_URL = "deleteachievement"
var ADD_FACE_2_FACE_URL = "addf2f"
var GET_TIP_URL = "gettip"
var GET_DRIVE_USER_DETAILS_URL = "getdriveuserdetails"
var ADD_CARRER_OBJECTIVE_URL = "getcareerobjective"
var GET_CARRER_OBJECTIVE_URL = "fetchcareerobjective"
var GET_EXTERNAL_DRIVES_URL = "getexternaldrives"
var GET_PLACEMENT_CATEGORY_URL = "getPlacementSubCat"
var GET_PLACEMENT_SUB_CATEGORY_URL = "gettipsbysubcategory"
var GET_CV_DATA_URL = "getcvdata"

var SOCIAL_LOGIN_PARAMS = "{\"user\": {\"email\": \"%@\",\"isActive\": \"1\",\"loginType\": \"%@\"},\"userPersonalDetails\": {\"firstName\":\"%@\",\"lastName\":\"%@\",\"email\":\"%@\",\"contacts\":\"%@\",\"iosId\":\"%@\",\"profilePic\":\"%@\"}}"

var Social_login_parameters = "{\"user\": {\"userName\":\"%@\",\"email\": \"%@\",\"isActive\": \"1\",\"loginType\": \"%@\",\"password\": \"%@\",\"fbProfile\": \"%@\",\"linkedIn\": \"%@\",\"googleProf\": \"%@\"},\"userProfile\": {\"firstName\":\"%@\",\"lastName\": \"%@\",\"dob\":\"%@\",\"gcmId\": \"%@\",\"iosId\": \"%@\",\"address\": \"testadd\",\"pinCode\": \"%@\",\"contacts\": \"%@\",\"sex\": \"%@\",\"maritalStatus\": \"%@\",\"nationality\": \"%@\",\"otp\": \"%@\",\"verified\": \"%@\",\"profilePic\": \"%@\"}}"


var CHECK_EMAIL_ID_PARAMS = "{\"email\":\"%@\"}"
var CHECK_OTP_PARAMS = "{\"user\":{\"userId\":\"%@\"},\"userProfile\":{\"otp\":\"%@\"}}"
var RESEND_OTP_PARAMS = "{\"userId\":\"%@\"}"
var GET_NOTIFICATION_PARAMS = "{\"notificationType\":\"4\"}"
var GET_LANGUAGE_PARAMS = "{}"
var GET_PLACEMENT_CATEGORY_PARAMS = "{}"
var GET_PLACEMENT_SUB_CATEGORY_PARAMS = "{\"subCategoryId\":\"%@\"}"
var GET_SKILLS_PARAMS = "{}"
var GET_STATE_PARAMS = "{}"
var GET_EXTERNAL_DRIVES_PARAMS = "{}"

var UPDATE_USER_PROFILE_DETAILS_PARAMS = "{\"user\":{\"userId\":\"%@\", \"email\":\"%@\"},\"userProfile\":{\"firstName\":\"%@\", \"lastName\":\"%@\", \"dob\":\"%@\", \"contacts\":\"%@\", \"sex\":\"%@\", \"maritalStatus\":\"%@\", \"profilePic\":\"%@\", \"city\":\"%@\", \"state\":\"%@\"}}"

var Profile_update = "{\"user\": {\"userId\": \"%@\",\"email\": \"%@\"},\"userProfile\": {\"firstName\": \"%@\",\"lastName\": \"%@\",\"dob\":\"%@\",\"contacts\": \"%@\",\"sex\": \"%@\",\"maritalStatus\": \"%@\",\"profilePic\": \"%@\",\"city\": \"%@\",\"state\":\"%@\"}}"

var GET_USER_PROFILE_DETAILS_PARAMS = "{\"userId\":\"%@\"}"
var GET_CITY_LIST_PARAMS = "{\"cityState\":\"maharashtra\"}"
var GET_COLLEGE_LIST_PARAMS = "{\"universityName\":\"%@\"}"
var GET_DEGREE_LIST_PARAMS = "{}"
var GET_SPECIALIZATION_PARAMS = "{\"degreeId\":\"%@\"}"
var GET_DRIVE_DOCUMENT_PARAMS = "{}"
var GET_CITY_COLLEGE_LIST_PARAMS = "{\"city\":{\"cityId\":\"%@\"}}"
var ADD_EDUCATION_DETAILS_PARAMS = "{\"eduDetailsId\": \"%@\",\"grades\": \"%@\",\"percentage\": \"%@\",\"cgpa\": \"%@\",\"passingYear\": \"%@\",\"degreeStatus\": \"%@\",\"users\": {\"userId\": \"%@\"},\"specializationName\": \"%@\",\"degreeName\": \"%@\",\"collegeName\": \"%@\",\"cityName\": \"%@\",\"universityName\": \"%@\",\"state\": \"%@\",\"level\": \"%@\",\"noYearDrop\": \"%@\",\"atKt\": \"true\"}"
var GET_EDUCATION_DETAILS_PARAMS = "{\"userId\":\"%@\"}"
var GET_UNIVERCITY_BY_STATE_PARAMS = "{\"state\":\"%@\"}"
var UPDATE_INTERESTS_PARAMS  = "{\"userInterestId\":\"%@\",\"interests\":\"%@\",\"userDefined\":\"%@\",\"user\":{\"userId\":\"%@\"}}"
var GET_INTERESTS_PARAMS = "{\"userId\":\"%@\"}"
var GET_SOCIAL_CONNECT_PARAMS = "{\"userId\":\"%@\"}"
var UPDATE_SOCIAL_CONNECT_PARAMS = "{\"blog\":\"%@\",\"whitePage\":\"%@\",\"linkedIn\":\"%@\",\"userId\":\"%@\"}"
var ADD_ACHIVEMENTS_PARAMS = "{\"achivement\": \"%@\",\"achivementYear\": \"%@\",\"user\": {\"userId\": \"%@\"}}"
var GET_ACHIVEMENTS_PARAMS = "{\"userId\":\"%@\"}"
var GET_USER_SKILLS_PARAMS = "{\"userId\":\"%@\"}"
var ADD_PROJECT_PARAMS = "{\"projectName\":\"%@\",\"teamsize\":\"%@\",\"role\":\"%@\",\"projectYear\":\"%@\",\"description\":\"%@\",\"user\":{\"userId\":\"%@\"}}"
var GET_PROJECT_PARAMS = "{\"userId\":\"%@\"}"
var UPDATE_LANGUAGES_PARAMS = "{\"userLangId\":\"%@\",\"user\":{\"userId\":\"%@\"},\"language\":\"%@\",\"read\":\"%@\",\"write\":\"%@\",\"speak\":\"%@\"}"
var GET_USER_LANGUAGES_PARAMS = "{\"userId\":\"%@\"}"
var GET_ELIGIBILITY_DRIVES_PARAMS = "{\"userId\":\"%@\"}"
var APPLY_FOR_DRIVE_PARAMS = "{\"status\":\"%@\",\"user\":{\"userId\":\"%@\"},\"recuDrive\":{\"recruitmentDriveId\":\"%@\"},\"emailNotification\":\"true\",\"companyName\":\"%@\"}"
var GET_APPLIED_DRIVES_PARAMS = "{\"userId\":\"%@\"}"
var GET_DRIVE_DETAILS_PARAMS = "{\"recruitmentDriveId\":\"%@\"}"
var GET_NON_ELIGIBILITY_DRIVES_PARAMS = "{\"userId\":\"%@\"}"
var EDIT_PROJECT_PARAMS = "{\"projectId\": \"%@\",\"projectName\": \"%@\",\"description\": \"%@\",\"role\": \"%@\",\"teamsize\": \"%@\",\"duration\": \"%@\",\"selfCompany\": \"%@\",\"projectYear\": \"%@\",\"companyName\": \"%@\",\"techUsed\": \"%@\"}"
var DELETE_PROJECT_PARAMS = "{\"projectId\":\"%@\"}"
var EDIT_LANGUAGE_PARAMS = "{\"userLangId\": \"%@\",\"language\": \"%@\",\"read\": \"%@\",\"write\": \"%@\",\"speak\": \"%@\"}"
var DELETE_LANGUAGE_PARAMS = "{\"userLangId\":\"%@\"}"
var EDIT_ACHIVEMENT_PARAMS = "{\"achivementId\":\"%@\",\"achivement\": \"%@\",\"achivementYear\": \"%@\"}"
var DELETE_ACHIVEMENT_PARAMS = "{\"achivementId\":\"%@\"}"
var ADD_FACE_2_FACE_PARAMS = "{\"comments\":\"%@\",\"status\":\"%@\",\"type\":\"%@\",\"paymentStatus\":\"%@\",\"paytmResponse\":\"%@\",\"user\":{\"userId\":\"%@\"}}"
var GET_TIP_PARAMS = "{\"tipsAndTopicsId\":\"%@\"}"
var GET_DRIVE_USER_DETAILS_PARAMS = "{\"batch\":{\"batchId\":\"%@\"},\"recuDrive\":{\"recruitmentDriveId\":\"%@\"}}"
var ADD_CARRER_OBJECTIVE_PARAMS = "{\"careerObjective\":\"%@\",\"userId\":\"%@\"}"
var GET_CARRER_OBJECTIVE_PARAMS = "{\"userId\":\"%@\"}"
var GET_CV_DATA_PARAMS = "{\"userId\":\"%@\"}"


//MARK:- Service url tags
enum kSERVICE_URL_TAG: Int {
    case social_login_url_tag = 100, social_email_exist_url_tag, check_otp_url_tag,resend_otp_url_tag, get_user_profile_url_tag, update_user_profile_url_tag, get_cv_data_url_tag, announcement_url_tag, get_achivements_url_tag, add_achivement_url_tag, add_projects_url_tag, add_more_achivement_url_tag, delete_achivement_url_tag, get_projects_url_tag, add_more_projects_url_tag, delete_projects_url_tag, get_languages_url_tag, get_user_languages_url_tag, add_more_languages_url_tag, add_languages_url_tag, delete_language_url_tag, get_skills_url_tag, notification_url_tag, get_state_url_tag, get_external_drives_url_tag, get_eligibility_drives_url_tag
    
}
var FONTNAME_LIGHT = "AppleSDGothicNeo-Regular"
var FONTNAME_BOLD  = "AppleSDGothicNeo-Bold"

var LFONT15 = UIFont(name: FONTNAME_BOLD, size: 15)
var LFONT16 = UIFont(name: FONTNAME_BOLD, size: 16)
var LFONT18 = UIFont(name: FONTNAME_BOLD, size: 18)






