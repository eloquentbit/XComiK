//
//  ArchiveTableViewController.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import UIKit

class ArchiveTableViewController: UITableViewController {
    
    //var lastComicNum = 0
    var comics = [Comic]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArchive(SettingsManager.lastComicId)
        
        navigationItem.title = "Archive"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        tableView.separatorStyle = .None
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func loadArchive(upTo: Int, numberOfComics count: Int? = SettingsManager.maxNumberOfComicsToFetch) {
        
        let api = APIManager()
        
        LoadingIndicatorView.show()
        
        for index in upTo-count!..<upTo {
            let url = "http://xkcd.com/\(index)/info.0.json"
            api.loadData(url, completion: didLoadArchiveData)
        }
    }
    
    func didLoadArchiveData(comic: Comic) {
        comics.append(comic)
                
        if comics.count == SettingsManager.maxNumberOfComicsToFetch {
            comics.sortInPlace { $0.cNum > $1.cNum }
            tableView.separatorStyle = .SingleLine
            tableView.reloadData()
            LoadingIndicatorView.hide()
        }
    }
    
    private struct storyboard {
        static let cellReuseIdentifier = "archiveCell"
        static let segueIdentifier = "comicDetail"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! ArchiveTableViewCell
        
        cell.comic = comics[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.alpha = 0
        
        UIView.animateWithDuration(1) { () -> Void in
            cell.alpha = 1
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier {
            if let indexpath = tableView.indexPathForSelectedRow {
                let comic = comics[indexpath.row]
                let dvc = segue.destinationViewController as! ComicDetailVC
                dvc.comic = comic
            }
        }
    }

}
