//
//  PermissionsViewController.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 12/12/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

protocol PermissionsDlegetae: NSObjectProtocol {
    func fetchCameraPermissionStatus(status: NSInteger)
    func fetchAssetsPermissionStatus(status: NSInteger)
}
class PermissionsViewController: UIViewController {
    var delegate: PermissionsDlegetae?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        func getCameraPermissionStatus() {
            if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
                // Already Authorized
            } else {
                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted: Bool) -> Void in
                    if granted == true {
                        // User granted
                        DispatchQueue.main.async {
                            if ((self.delegate) != nil) {
                                self.delegate?.fetchAssetsPermissionStatus(status: 1)
                            }
                        }
                    } else {
                        // User Rejected
                        DispatchQueue.main.async {
                            if ((self.delegate) != nil) {
                                self.delegate?.fetchAssetsPermissionStatus(status: 0)
                            }
                        }
                    }
                })
            }
        }
        func getAssetsPermissionStatus() {
//            if Float(UIDevice.current.systemVersion) ?? 0.0 > 9.0 {
//
//            }
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    if ((self.delegate) != nil) {
                        self.delegate?.fetchAssetsPermissionStatus(status: 1)
                    }
                }
                break
            case .denied, .restricted :
            //handle denied status
                DispatchQueue.main.async {
                    if ((self.delegate) != nil) {
                        self.delegate?.fetchAssetsPermissionStatus(status: 0)
                    }
                }
                break
            case .notDetermined:
                // ask for permissions
                PHPhotoLibrary.requestAuthorization() { status in
                    switch status {
                    case .authorized:
                    // as above
                        DispatchQueue.main.async {
                            if ((self.delegate) != nil) {
                                self.delegate?.fetchAssetsPermissionStatus(status: 1)
                            }
                        }
                        break
                    case .denied, .restricted:
                    // as above
                        DispatchQueue.main.async {
                            if ((self.delegate) != nil) {
                                self.delegate?.fetchAssetsPermissionStatus(status: 0)
                            }
                        }
                        break
                    case .notDetermined:
                        DispatchQueue.main.async {
                            if ((self.delegate) != nil) {
                                self.delegate?.fetchAssetsPermissionStatus(status: 0)
                            }
                        }
                        break
                    }
                }
            }
        }
    }

    

}
