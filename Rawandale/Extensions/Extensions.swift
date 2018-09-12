//
//  Extensions.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 19/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension UIImageView {
    
    func cropAsCircleWithBorder(borderColor : UIColor, borderWidth: CGFloat) {
        var radius = min(self.bounds.width, self.bounds.height)
        var drawingRect : CGRect = self.bounds
        drawingRect.size.width = radius
        drawingRect.origin.x = (self.bounds.size.width - radius) / 2
        drawingRect.size.height = radius
        drawingRect.origin.y = (self.bounds.size.height - radius) / 2
        
        radius /= 2
        
        var path = UIBezierPath(roundedRect: drawingRect.insetBy(dx: borderWidth/2, dy: borderWidth/2), cornerRadius: radius)
        let border = CAShapeLayer()
        border.fillColor = UIColor.clear.cgColor
        border.path = path.cgPath
        border.strokeColor = borderColor.cgColor
        border.lineWidth = borderWidth
        self.layer.addSublayer(border)
        
        path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
extension UIImage {
    
    func cropWithColorAndBorderWidth(borderColor: UIColor, borderWidth:CGFloat) -> UIImage {
        let imgRect = CGRect(origin:.zero, size: self.size)
        UIGraphicsBeginImageContext(imgRect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.addEllipse(in: imgRect)
        context?.clip()
        self.draw(at: .zero)
        borderColor.setStroke()
        context?.setLineWidth(borderWidth)
        context?.strokePath()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage!
    }
}
// MARK:- String
extension String {
    func isEqualToString(responseStr: String) -> Bool {
        return String(format: self) == responseStr
    }
}
//MARK:- Universal alert
extension UIViewController {
    func showUniversalAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
