//
//  APIManager.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: Comic -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                let comic = self.parseJson(data)
                
                let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(comic)
                    }
                }
            }
            
        }
        
        task.resume()
    }
    
    func parseJson(data: NSData?) -> Comic {
        
        do {
            
            if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as AnyObject? {
                return JsonDataExtractor.extractComicDataFromJson(json)
            }
        } catch {
            print("Failed to parse data: \(error)")
        }
        
        return Comic()
    }
    
}