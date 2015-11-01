//
//  TweetDetailTableViewController.swift
//  smashtagpd
//
//  Created by Paul Donlan on 10/13/15.
//  Copyright © 2015 Paul Donlan. All rights reserved.
//

import UIKit

class TweetDetailTableViewController: UITableViewController {
    
    private struct Storyboard {
        static let cellIdent = "TweetDetail"
    }
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }

    func updateUI(){
        self.title = "\(tweet?.user)" //tweet?.id
        // get table view to display two sections say hashtags and mentions then query # of sections and return ttiles
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {return tweet?.hashtags.count ?? 0}
        if section == 1 {return tweet?.userMentions.count ?? 0}
        if section == 2 {return tweet?.urls.count ?? 0}
        return 0
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // if a section is empty return nil for title so it wont show.
        if self.tableView(tableView,  numberOfRowsInSection: section) == 0 {
            return nil
        }
        
        switch (section){
            
            case 0: return "hashtags"
            case 1: return "mentions"
            case 2: return "URLs"
            default: return ""
            
        }
        
    }
    
    //todo: add urls, then clean up code, then deal with clicking on a user/url/hashtag to initiate a new search. Then deal with media items (photos)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.cellIdent, forIndexPath: indexPath)

        // Configure the cell... 
        
        switch (indexPath.section) {
        case 0: cell.textLabel?.text = tweet?.hashtags[indexPath.row].keyword
        case 1: cell.textLabel?.text = tweet?.userMentions[indexPath.row].keyword
        case 2: cell.textLabel?.text = tweet?.urls[indexPath.row].keyword
        default: break

        }
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
