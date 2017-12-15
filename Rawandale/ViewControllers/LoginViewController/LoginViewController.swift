//
//  LoginViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 18/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: RootViewController, GIDSignInDelegate, GIDSignInUIDelegate, ClassForServerCommDelegate {
    
    var parentNavigationController : UINavigationController?
    @IBOutlet weak var joinNowLbl: UILabel!
    @IBOutlet weak var welcomeTxtLbl: UILabel!
    @IBOutlet weak var networkLbl: UILabel!
    @IBOutlet weak var internetView: UIView!
    var dict : [String : AnyObject]!
    let reachability = Reachability()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInputViews()
        
    }
    func loadInputViews () {
        //self.internetView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        GIDSignIn.sharedInstance().clientID = GOOGLE_CLIENT_ID
        GIDSignIn.sharedInstance().scopes = ["profile", "email"]
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    //MARK:- Social media logins
    @IBAction func socialMediaLoginPressed(_ sender: UIButton) {
        print("sender value \(sender.tag)")
        switch sender.tag {
        case 1:
            self.fnForFacebookButtonPressed()
        break
        case 2:
            self.fnForGmailBtnPressed()
            break
        case 3:
            self.fnForLinkedInBtnPressed()
            break
        default:
            print("Others")
            break
        }
    }

    //MARK:- Google sign in
    func fnForGmailBtnPressed () {
        if self.isConnectedToNetwork() == false {
            print("No internet connection")
        }
        else {
            //self.fnForSignUpViewController()
            GIDSignIn.sharedInstance().signOut()
            GIDSignIn.sharedInstance().signIn()
        }
    }
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            var imageUrlStr = ""
            if user.profile.hasImage {
                imageUrlStr = user.profile .imageURL(withDimension: 100).absoluteString
                print(imageUrlStr)
            }
            
            
            var firstNameStr = ""
            if ((user.profile.givenName)as AnyObject as? NSNull) != NSNull() {
                firstNameStr = user.profile.givenName
                print(firstNameStr)
            }
            var lastNameStr = ""
            if ((user.profile.familyName)as AnyObject as? NSNull) != NSNull() {
                lastNameStr = user.profile.familyName
                print(lastNameStr)
            }
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let firstName = user.profile.givenName
            let lastName = user.profile.familyName
            let email = user.profile.email
//            let gander = us

            let profileImageUrl = user.profile.imageURL(withDimension: 200)
            print("Image url \(String(describing: profileImageUrl))")
            let url = profileImageUrl?.absoluteString
            let imageUrl = NSURL(string: url!)
            let imageData = try? Data(contentsOf: imageUrl! as URL)
            let image: UIImage = UIImage(data: imageData!)!
            let myImageData:NSData = UIImagePNGRepresentation(image) as NSData!
            
            print(userId!,idToken!,fullName!,firstName!,lastName!,email!, url!)
            
            
            
            
            /*
            let gplusapi = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=\(user.authentication.accessToken!)"
            let url1 = NSURL(string: gplusapi)!
            let request = NSMutableURLRequest(url: url1 as URL)
            request.httpMethod = "GET"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                do {
                    let userData = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String:AnyObject]
                    print("Data is \(userData!)")
                    let picture = userData!["picture"] as! String
                    let gender = userData!["gender"] as! String
                    let locale = userData!["locale"] as! String
                    
                } catch {
                    NSLog("Account Information could not be loaded")
                }
                
            }).resume()*/
            
             // Data saving in UserDefaults
             let userDefaults = UserDefaults.standard
             userDefaults.set(fullName, forKey: "FullName")
             userDefaults.set(firstName, forKey: "FirstName")
             userDefaults.set(lastName, forKey: "LastName")
             userDefaults.set(email, forKey: "EMailId")
             userDefaults.set(imageUrlStr, forKey: "SavedMyImage")
             userDefaults.synchronize()
    
            self.socialEmailExist()
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
              withError error: Error!) {
        
    }
    
    // MARK:- Facebook login
    func fnForFacebookButtonPressed () {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email", "public_profile", "user_friends"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((FBSDKAccessToken.current()) != nil){
                            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, gender, user_birthday, user_hometown"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    self.dict = result as! [String : AnyObject]
                                    print(result!)
                                    print(self.dict)
//                                    let name = self.dict["name"] as! String
//                                    let email = self.dict["email"] as! String
                                    let picture = self.dict["picture"] as! NSDictionary
                                    let data = picture["data"] as! NSDictionary
                                    let urlString = data["url"] as! String
                                    let imageUrl = NSURL(string: urlString)
                                    let imageData = try? Data(contentsOf: imageUrl! as URL)
                                    let image: UIImage = UIImage(data: imageData!)!
                                    let myImageData:NSData = UIImagePNGRepresentation(image) as NSData!
                                    let userDefaults = UserDefaults.standard
                                    userDefaults.set(self.dict["name"] as! String, forKey: "FullName")
                                    userDefaults.set(self.dict["email"] as! String, forKey: "EMailId")
                                    userDefaults.set(myImageData, forKey: "SavedMyImage")
                                    userDefaults.synchronize()
                                    self.socialEmailExist()
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    // MARK:- Linked in Signin
    func fnForLinkedInBtnPressed () {
        print("Linked in btn clicked")
        self.fnForSignUpViewController()
      
    }
    
    //MARK:- Social Email Exist
    func socialEmailExist () {
        let checkEmailParams = String(format:CHECK_EMAIL_ID_PARAMS, UserDefaults.standard.object(forKey: "EMailId") as! CVarArg)
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("",checkEmailParams)
        kServiceUrlTag = kSERVICE_URL_TAG.social_email_exist_url_tag.rawValue
        serverCommObj.sendHttpPostRequestWithParam(parameterString: checkEmailParams, serviceName: CHECK_EMAIL_URL)
    }
    
    // MARK:- Social sign
    func fnForSocialLogin () {
//        let userId = UserDefaults.standard.object(forKey: "EMailId") as! String
//        let socialLoginParams = String(format:Social_login_parameters,userId,"ios")
//        let serverCommObj = ServerCommunication()
//        serverCommObj.delegate = self
//        print("",socialLoginParams)
//        kServiceUrlTag = kSERVICE_URL_TAG.social_login_url_tag.rawValue
//        serverCommObj.sendHttpPostRequestWithParam(parameterString: socialLoginParams, serviceName: SOCIAL_URL)
    }
    
    // MARK:- Service success method
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        switch kServiceUrlTag {
        case kSERVICE_URL_TAG.social_email_exist_url_tag.rawValue:
            let message = responseDictionary["message"] as! String
            if message == "Email already exists" {
                print(message)
            }
            else {
                perform(#selector(self.fnForSocialLogin), with: self, afterDelay: 0.1)
            }
            break
        case kSERVICE_URL_TAG.social_login_url_tag.rawValue:
            print("language")
            break
        default:
            break
            
        }
    }
    func onServiceFailed() {
        print("Service failed")
    }
    
    
    
    
    
}
