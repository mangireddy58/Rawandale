//
//  VideoViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 14/12/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class VideoViewController: RootViewController {
    
    @IBOutlet var videoViewPlayer: YouTubePlayerView!
    @IBOutlet weak var topicNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadInputViews()
    }
    func loadInputViews() {
        print("video dict", (self.objUniversalDataModel?.videoDataDict) as NSDictionary!)
        if (self.objUniversalDataModel?.videoDataDict.value(forKey: "topicName")as AnyObject) as? NSNull != NSNull() {
            if (self.objUniversalDataModel?.videoDataDict.value(forKey: "topicName") as AnyObject).length() > 0 {
                self.topicNameLabel.text = ((self.objUniversalDataModel?.videoDataDict.value(forKey: "topicName")  as? String)!)
            }
        }
        if (self.objUniversalDataModel?.videoDataDict.value(forKey: "videoUrl")as AnyObject) as? NSNull != NSNull() {
            if (self.objUniversalDataModel?.videoDataDict.value(forKey: "videoUrl") as AnyObject).length() > 0 {
                let url = self.getYoutubeId(youtubeUrl: (self.objUniversalDataModel?.videoDataDict.value(forKey: "videoUrl")  as? String)!)
                videoViewPlayer.loadVideoID(url!)
                videoViewPlayer.play()
            }
        }
        
    }
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
    @IBAction func backAction(_ sender: Any) {
        videoViewPlayer.stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
