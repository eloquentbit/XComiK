//
//  ComicDetailVC.swift
//  XComiK
//
//  Created by Luca Peduto on 30/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import UIKit

class ComicDetailVC: UIViewController {
    
    var comic: Comic!
    
    
    @IBOutlet weak var comicDateLabel: UILabel!
    @IBOutlet weak var comicNumLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicAltLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        self.navigationItem.title = comic.cTitle
        comicDateLabel.text = comic.displayDate()
        comicNumLabel.text = "#\(comic.cNum)"
        comicAltLabel.text = comic.cAltText
        
        if comic.vImageData != nil {
            comicImageView.image = UIImage(data: comic.vImageData!)
        } else {
            GetVideoImage(comic, imageView: comicImageView)
        }
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Graviola Soft", size: 20.0)!]
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
