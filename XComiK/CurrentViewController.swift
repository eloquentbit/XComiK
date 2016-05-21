//
//  CurrentViewController.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController {

    private var comic: Comic?
    
    @IBOutlet weak var comicDateLabel: UILabel!
    @IBOutlet weak var comicNumLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicAltLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrive the last comic
        getComic()
    }
    
    // MARK: - ToDO
    func addComicToFavorites(sender: AnyObject) {
        print("Image \(comic!.cNum) tapped")
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
        self.comic = comic
        
        SettingsManager.lastComicId = comic.cNum
        
        setupView(comic)
        
    }
    
    private func setupView(comic: Comic) {
        comicDateLabel.text = comic.displayDate()
        comicNumLabel.text = "#\(comic.cNum)"
        comicAltLabel.text = comic.cAltText
        
        navigationItem.title = comic.cTitle
//        navigationController?.navigationBar.titleTextAttributes = [
//            NSForegroundColorAttributeName: UIColor.whiteColor(),
//            NSFontAttributeName: UIFont(name: "Graviola Soft", size: 20.0)!]
        
        if comic.vImageData != nil {
            print("Get data from array...")
            comicImageView.image = UIImage(data: comic.vImageData!)
        } else {
            print("Get images in background thread")
            GetVideoImage(comic, imageView: comicImageView)
        }
        
        let tapGesture = UITapGestureRecognizer()
        let tapSelector : Selector = "addComicToFavorites:"
        tapGesture.numberOfTapsRequired = 2
        tapGesture.addTarget(self, action: tapSelector)
        comicImageView.addGestureRecognizer(tapGesture)
    }
    
    private func GetVideoImage(comic: Comic, imageView: UIImageView) {
        
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
