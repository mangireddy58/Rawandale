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

    
    var dataDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getPlacementTips()
    }

    func getPlacementTips () {
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
            self.objUniversalDataModel?.videoDataDict = self.dataDict
            if (self.dataDict.value(forKey: "profileImage")as AnyObject) as? NSNull != NSNull() {
                if (self.dataDict.value(forKey: "profileImage") as AnyObject).length() > 0 {
                    videoImageView.sd_setImage(with: URL(string: (self.dataDict.value(forKey: "profileImage")  as? String)!), placeholderImage: UIImage(named: "Default_user"))
                }
            }
            
//            profileImage
            let videoTapGesture = UITapGestureRecognizer(target: self, action: #selector(playVideo))
            videoImageView.addGestureRecognizer(videoTapGesture)
            videoImageView.isUserInteractionEnabled = true
            videoImageView.contentMode = .scaleAspectFill
        }
    }
    
    func onServiceFailed() {
        self.hideProgressIndicator()
        print("Service Failed")
    }
    func playVideo(videotapGesture:UITapGestureRecognizer) {
        
        let signUp = storyBoard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
        self.present(signUp, animated: true, completion: nil)
//        self.videoPlayer.allow
//        videoPlayer.play()
//        let url:String = "https://www.youtube.com/watch?v=keP5KB52__Y"
//        let videoURL = NSURL(string: url)
//        let player = AVPlayer(url: videoURL! as URL)
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        self .present(playerController, animated: true) {
//            playerController.player?.play()
//        }
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
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
