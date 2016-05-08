//
//  Comic.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import Foundation

class Comic {
    
    private(set) var cTitle:String
    private(set) var cImageUrl:String
    private(set) var cNum:Int
    private(set) var cAltText:String
    private(set) var cYear:String
    private(set) var cMonth:String
    private(set) var cDay:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    init() {
        self.cTitle = ""
        self.cImageUrl = ""
        self.cNum = 0
        self.cAltText = ""
        self.cYear = ""
        self.cMonth = ""
        self.cDay = ""
    }
    
    init(cTitle: String, cImageUrl: String, cNum: Int, cAltText: String, cYear: String, cMonth: String, cDay: String) {
        
        self.cTitle = cTitle
        self.cImageUrl = cImageUrl
        self.cNum = cNum
        self.cAltText = cAltText
        self.cYear = cYear
        self.cMonth = cMonth
        self.cDay = cDay
                
    }
    
    func displayDate() -> String {
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.day = Int(self.cDay)!
        components.month = Int(self.cMonth)!
        components.year = Int(self.cYear)!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        let rawDate = calendar!.dateFromComponents(components)
        let comicDate = dateFormatter.stringFromDate(rawDate!)
        
        return comicDate
    }
}
