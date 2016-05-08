//
//  SettingsManager.swift
//  XComiK
//
//  Created by Luca Peduto on 08/05/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import Foundation

struct SettingsManager {
    
    static var defaults = NSUserDefaults.standardUserDefaults()
    
    static var lastComicId: Int {
        get {
            return defaults.integerForKey("lastComicId")
        }
        set {
            defaults.setInteger(newValue, forKey: "lastComicId")
        }
    }
    
    static var maxNumberOfComicsToFetch = 100
    
}