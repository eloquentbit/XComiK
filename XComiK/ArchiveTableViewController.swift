//
//  ArchiveTableViewController.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import UIKit

class ArchiveTableViewController: UITableViewController {
    
    var lastComicNum = 0
    var comics = [Comic]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserSettings()
        
        loadArchive(lastComicNum)
        
        navigationItem.title = "Archive"
        tableView.separatorStyle = .None
        LoadingIndicatorView.show(self.view, loadingText: "Loading comics...")

    }
    
    func loadUserSettings() {
        lastComicNum = NSUserDefaults.standardUserDefaults().integerForKey("lastComicNum")
    }
    
    func loadArchive(upTo: Int, numberOfComics count: Int? = 100) {
        
        let api = APIManager()
        
        for index in upTo-count!..<upTo {
            let url = "http://xkcd.com/\(index)/info.0.json"
            api.loadData(url, completion: didLoadArchiveData)
        }
    }
    
    func didLoadArchiveData(comic: Comic) {
        comics.append(comic)
        
        if comics.count == 100 {
            comics.sortInPlace { $0.cNum > $1.cNum }
            tableView.separatorStyle = .SingleLine
            LoadingIndicatorView.hide()
            tableView.reloadData()
        }
    }
    
    private struct storyboard {
        static let cellReuseIdentifier = "archiveCell"
        static let segueIdentifier = "comicDetail"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
