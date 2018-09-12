//
//  PlacementTipViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 29/11/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import AVKit
import YouTubePlayer_Swift

class PlacementTipViewController: RootViewController, ClassForServerCommDelegate {

    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet var videoViewPlayer: YouTubePlayerView!
    
    var dataDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getPlacementTips()
    }

    func getPlacementTips () {
        let videoTapGesture = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        videoImageView.addGestureRecognizer(videoTapGesture)
        videoImageView.isUserInteractionEnabled = true
        videoImageView.contentMode = .scaleAspectFill
        
        self.showLoadingIndicator()
        let placementTipParams = String(format:GET_TIP_PARAMS,(self.objUniversalDataModel?.placementTipsAndTopicId)!)
        let serverCommObj = ServerCommunication()
        serverCommObj.delegate = self
        print("Tips params",placementTipParams)
        serverCommObj.sendHttpPostRequestWithParam(parameterString: placementTipParams, serviceName:GET_TIP_URL)
    }
    
    func onServiceSuccess(responseDictionary: NSDictionary) {
        print(responseDictionary)
        self.hideProgressIndicator()
        let message = responseDictionary["success"] as! Int
        if message == 1 {
            self.dataDict = (responseDictionary["data"] as! NSDictionary)
            print("data is ", self.dataDict)
            if (self.dataDict.value(forKey: "topicName")as AnyObject) as? NSNull != NSNull() {
                if (self.dataDict.value(forKey: "topicName") as AnyObject).length() > 0 {
                   self.titleNameLabel?.text = (self.dataDict.value(forKey: "topicName")  as? String)!
                }
            }
            
            if (self.dataDict.value(forKey: "updatedDate")as AnyObject) as? NSNull != NSNull() {
                if (self.dataDict.value(forKey: "updatedDate") as AnyObject).length() > 0 {
                    self.dateLabel?.text = (self.changeDateFormatWithDate(dateString:(self.dataDict.value(forKey: "updatedDate")  as? String)!))
                }
            }
            
            if (self.dataDict.value(forKey: "profileImage")as AnyObject) as? NSNull != NSNull() {
                if (self.dataDict.value(forKey: "profileImage") as AnyObject).length() > 0 {
                    videoImageView.sd_setImage(with: URL(string: (self.dataDict.value(forKey: "profileImage")  as? String)!), placeholderImage: UIImage(named: "Default_user"))
                }
            }
        }
        else {
            print(responseDictionary["message"] as! String)
        }
    }
    func onServiceFailed() {
        self.hideProgressIndicator()
        print("Service Failed")
    }
    // MARK:- Finding youtube Id
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
    // MARK:- Video Playing
    func playVideo(videotapGesture:UITapGestureRecognizer) {
        self.showLoadingIndicator()
        self.videoImageView.isHidden = true
        if (self.dataDict.value(forKey: "videoUrl")as AnyObject) as? NSNull != NSNull() {
            if (self.dataDict.value(forKey: "videoUrl") as AnyObject).length() > 0 {
                let url = self.getYoutubeId(youtubeUrl: (self.dataDict.value(forKey: "videoUrl")  as? String)!)
                videoViewPlayer.loadVideoID(url!)
                videoViewPlayer.play()
                self.hideProgressIndicator()
            }
        }
    }
    // MARK:- Back
    @IBAction func backButtonPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    // MARK:- Share
    @IBAction func shareButtonPressed(_ sender: Any) {
        print("share app")
        let userDeafults = UserDefaults.standard
        let userName = userDeafults.object(forKey: "FullName")
        let message = NSString(format:"has invited you to join Rawandale app. To find out more please visit our App:")
        let activityController = UIActivityViewController(activityItems: [userName!,message], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        self.present(activityController, animated: true, completion: nil)
    }

}
