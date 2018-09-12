//
//  RevealViewController.swift
//
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class RevealViewController: SWRevealViewController, SWRevealViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.frontViewShadowColor = .clear
        
        tapGestureRecognizer()
        panGestureRecognizer()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            
            let controller = self.frontViewController
            var frame = controller?.view.frame
            if size.width > size.height { // Landscape
                if self.frontViewPosition == .left {
                    self.revealToggle(animated: false)
                }
                frame?.size.width = UIScreen.main.bounds.size.width - self.rearViewRevealWidth
            }
            else {
                frame?.size.width = UIScreen.main.bounds.size.width
            }
            
            controller?.view.frame = frame!
        })
    }
    
    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            return false
        }
        return true
    }
    
    func revealControllerTapGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            return false
        }
        return true
    }
}
/*
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        print("identifier: \(identifier)")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if identifier == "sw_front" {
            if UIDevice.current.userInterfaceIdiom == .phone {
                frontViewController = storyBoard.instantiateViewController(withIdentifier: "IPhoneNavigationController")
            }
            else {
                frontViewController = storyBoard.instantiateViewController(withIdentifier: "IPadNavigationController")
            }
        }
        if identifier == "sw_rear" {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            rearViewController = storyBoard.instantiateViewController(withIdentifier: "RearViewController")
        }
    }
}
*/
