//
//  JsonDataExtractor.swift
//  XComiK
//
//  Created by Luca Peduto on 08/05/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import Foundation

class JsonDataExtractor {
    
    static func extractComicDataFromJson(comicDataObject: AnyObject) -> Comic {
        
        guard let comicData = comicDataObject as? JSONDictionary else { return Comic() }
        
        var cTitle = "",
            cImageUrl = "",
            cNum = 0,
            cAltText = "",
            cYear = "",
            cMonth = "",
            cDay = ""
        
        // Comic title
        if let title = comicData["title"] as? String {
            cTitle = title
        }
        
        // Comic image
        if let imgUrl = comicData["img"] as? String {
            cImageUrl = imgUrl
        }
        
        // Comic number
        if let num = comicData["num"] as? Int {
            cNum = num
        }
        
        // Comic description
        if let altText = comicData["alt"] as? String {
            cAltText = altText
        }
        
        // Comic year
        if let year = comicData["year"] as? String {
            cYear = year
        }
        
        // Comic month
        if let month = comicData["month"] as? String {
            cMonth = month
        }
        
        // Comic day
        if let day = comicData["day"] as? String {
            cDay = day
        }
        
        let currentComic = Comic(cTitle: cTitle, cImageUrl: cImageUrl, cNum: cNum, cAltText: cAltText, cYear: cYear, cMonth: cMonth, cDay: cDay)
        
        return currentComic
    }
}