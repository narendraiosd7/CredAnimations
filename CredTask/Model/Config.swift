//
//  Config.swift
//  CredTask
//
//  Created by narendra.vadde on 27/06/21.
//

import UIKit
import Foundation

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

class Config {
    static let shared = Config()
    
    var strings: StaticData = StaticData()
    var fontStyles:Font = Font()
    var colors:Theme = Theme()
    var images:ImageNames = ImageNames()
    var keys:Key = Key()
}

class Key {
    
}

class StaticData {

    init() {
        
    }
}

class Font {
    
}

class Theme {
    var backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //rgba(0, 0, 0, 1)
    var barColor = #colorLiteral(red: 0.9882352941, green: 0.9176470588, blue: 0.8705882353, alpha: 1) //rgba(252, 234, 222, 1)
    var trackingColor = #colorLiteral(red: 0.8235294118, green: 0.5490196078, blue: 0.431372549, alpha: 1) //rgba(210, 140, 110, 1)
}

class ImageNames {
    var uncheck = "uncheck"
    var unchecked = "unchecked"
    var hdfcAcc = "hdfcAcc"
    var check = "check"
}



