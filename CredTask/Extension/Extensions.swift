//
//  Extensions.swift
//  CrediOSTask
//
//  Created by narendra.vadde on 26/06/21.
//

import UIKit

extension UIView {
    func roundCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func topCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

extension UIButton {
    func customBorderButton(_ color: UIColor, _ borderWidth: CGFloat, _ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
}
