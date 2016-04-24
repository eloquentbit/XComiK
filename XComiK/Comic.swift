//
//  Comic.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import Foundation

class Comic {
    private var _cTitle:String
    private var _cImageUrl:String
    private var _cNum:Int
    private var _cAltText:String
    private var _cYear:String
    private var _cMonth:String
    private var _cDay:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    var cTitle: String {
        return _cTitle
    }
    
    var cImageUrl: String {
        return _cImageUrl
    }
    
    var cNum:Int {
        return _cNum
    }
    
    var cAltText: String {
        return _cAltText
    }
    
    var cYear: String {
        return _cYear
    }
    
    var cMonth: String {
        return _cMonth
    }
    
    var cDay: String {
        return _cDay
    }
    
    init(data: JSONDictionary) {
        
        // Comic title
        if let title = data["title"] as? String {
            self._cTitle = title
        } else {
            _cTitle = ""
        }
        
        // Comic image
        if let imgUrl = data["img"] as? String {
            self._cImageUrl = imgUrl
        } else {
            _cImageUrl = ""
        }
        
        // Comic number
        if let num = data["num"] as? Int {
            self._cNum = num
        } else {
            _cNum = 0
        }
        
        // Comic description
        if let altText = data["alt"] as? String {
            self._cAltText = altText
        } else {
            _cAltText = ""
        }
        
        // Comic year
        if let year = data["year"] as? String {
            self._cYear = year
        } else {
            _cYear = ""
        }
        
        // Comic month
        if let month = data["month"] as? String {
            self._cMonth = month
        } else {
            _cMonth = ""
        }
        
        // Comic day
        if let day = data["day"] as? String {
            self._cDay = day
        } else {
            _cDay = ""
        }
        
    }
    
    func displayDate() -> String {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.day = Int(self._cDay)!
        components.month = Int(self._cMonth)!
        components.year = Int(self._cYear)!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        let rawDate = calendar!.dateFromComponents(components)
        let comicDate = dateFormatter.stringFromDate(rawDate!)
        
        return comicDate
    }
}
