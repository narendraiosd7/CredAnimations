//
//  ViewAnimations.swift
//  CrediOSTask
//
//  Created by narendra.vadde on 26/06/21.
//

import UIKit

enum ViewAnimationFactory {
    static func makeEaseInAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            action()
        })
    }
    
    static func makeEaseInOutAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            action()
        })
    }
    
    static func makeEaseOutAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            action()
        })
    }

    static func makeSimpleAnimation(duration: TimeInterval, action: @escaping() -> Void){
        UIView.animate(withDuration: duration) {
            action()
        }
    }
}
