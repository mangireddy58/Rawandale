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
import LinkedinSwift

class LoginViewController: RootViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
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
        // For rechability
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                self.networkLbl.text = "Internet connected"
                self.networkLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                // self.internetView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                self.internetView.isHidden = false
            }
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.networkLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.networkLbl.text = "Internet not connected"
                self.internetView.isHidden = false
                //                self.internetView.backgroundColor = #colorLiteral(red: 0.8048847317, green: 0.4376866966, blue: 0.2836556642, alpha: 1)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: ReachabilityChangedNotification, object: reachability)
        do{
            try reachability.startNotifier()
        }catch {
            print("could not start notifier")
        }
    }
    func loadInputViews () {
        //self.internetView.isHidden = true
        
    }
    func internetChanged (note:Notification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                DispatchQueue.main.async {
                    //self.internetView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                    self.internetView.isHidden = true
                }
            }else {
                DispatchQueue.main.async {
                    self.internetView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                }
            }
        }else {
            self.internetView.isHidden = false
            self.networkLbl.text = "Internet not connected"
            self.networkLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.internetView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            //self.internetView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
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
        print("Gmail btn clicked")
        //self.fnForSignUpViewController()
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            print(userId!,idToken!,fullName!,givenName!,familyName!,email!)
            
            // Data saving in UserDefaults
             let userDefaults = UserDefaults.standard
             userDefaults.set(fullName, forKey: "FullName")
             userDefaults.set(email, forKey: "EMailId")
             userDefaults.synchronize()
            
            self.fnForSignUpViewController()
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    // MARK:- Facebook login
    func fnForFacebookButtonPressed () {
        print("Facebook btn clicked")
//        self.fnForSignUpViewController()
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email", "public_profile", "user_friends"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((FBSDKAccessToken.current()) != nil){
                            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
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
                                    self.fnForSignUpViewController()
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
    
    
    
    
    
    
    
}
