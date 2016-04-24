//
//  CurrentViewController.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController {

    @IBOutlet weak var comicDateLabel: UILabel!
    @IBOutlet weak var comicNumLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicAltLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getComic()
        
    }
    
    func getComic(comicNum:Int? = nil) {
        let api = APIManager()
        
        if let comicNum = comicNum {
            api.loadData("http://xkcd.com/\(comicNum)/info.0.json", completion: didLoadData)
        } else {
            api.loadData("http://xkcd.com/info.0.json", completion: didLoadData)
        }
    }
    
    func didLoadData(comic: Comic) {
        self.navigationItem.title = comic.cTitle
        comicDateLabel.text = comic.displayDate()
        comicNumLabel.text = "#\(comic.cNum)"
        comicAltLabel.text = comic.cAltText
        
        if comic.vImageData != nil {
            print("Get data from array...")
            comicImageView.image = UIImage(data: comic.vImageData!)
        } else {
            print("Get images in background thread")
            GetVideoImage(comic, imageView: comicImageView)
        }
        
    }
    
    func GetVideoImage(comic: Comic, imageView: UIImageView) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: comic.cImageUrl)!)
            
            var image: UIImage!
            if data != nil {
                comic.vImageData = data
                image = UIImage(data: data!)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
        
    }

}
