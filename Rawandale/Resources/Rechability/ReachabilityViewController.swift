//
//  RechabilityViewController.swift
//  SwiftP
//
//  Created by Rushikesh Kulkarni on 12/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

class ReachabilityViewController: RootViewController {
    
    let reachability = Reachability()!
    
    @IBOutlet weak var networkLbl: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                self.networkLbl.text = "Internet connected"
                self.networkLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.contentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.networkLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.networkLbl.text = "Internet not connected"
                self.contentView.backgroundColor = #colorLiteral(red: 0.8048847317, green: 0.4376866966, blue: 0.2836556642, alpha: 1)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: ReachabilityChangedNotification, object: reachability)
        do{
            try reachability.startNotifier()
        }catch {
            print("could not start notifier")
        }
        
    }
    func internetChanged (note:Notification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                DispatchQueue.main.async {
                    self.view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                }
            }else {
                DispatchQueue.main.async {
                    self.view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                }
            }
        }else {
            self.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
    }
    
}
