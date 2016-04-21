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
        self.title = "Tweet Detail"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension //calculate size

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
    
    private var sections = ["hashtags", "mentions", "URLs", "Photos"]

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, compute & return the number of sections
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return the number of rows for a give section
        
        switch (sections[section]) {
        
        case "hashtags": return tweet?.hashtags.count ?? 0
        case "mentions": return tweet?.userMentions.count ?? 0
        case "URLs": return tweet?.urls.count ?? 0
        case "Photos": return tweet?.media.count ?? 0
        default: return 0
            
        }
    }

    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // if a section is empty return nil for title so it wont show.
        if self.tableView(tableView,  numberOfRowsInSection: section) == 0 {
            return nil
        }

        return sections[section];
    }
    
    //todo: return to MVC issues, deal with media items (photos)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.cellIdent, forIndexPath: indexPath)

        // Configure the cell... 
        
        switch sections[indexPath.section] {
        case "hashtags": cell.textLabel?.text = tweet?.hashtags[indexPath.row].keyword
        case "mentions": cell.textLabel?.text = tweet?.userMentions[indexPath.row].keyword
        case "URLs": cell.textLabel?.text = tweet?.urls[indexPath.row].keyword
        case "Photos":
            cell.textLabel?.text = tweet?.media[indexPath.row].description
            let imageURL = tweet?.media[indexPath.row].url
            let imageAspectRatio = tweet?.media[indexPath.row].aspectRatio
            let imageData = NSData(contentsOfURL: imageURL!)
            cell.imageView?.image = UIImage(data: imageData!,scale: CGFloat(imageAspectRatio!))

        default: break

        }

        return cell
    }
    
    
    // MARK: clicks on entry
    var testCase = "nothing"
    var content = "#wombat"
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (sections[indexPath.section]) {
            case "hashtags":
                    content = (tweet?.hashtags[indexPath.row].keyword)!
                    testCase = "hashtag"
                    self.performSegueWithIdentifier("newTweetSearch", sender:indexPath)

            case "mentions":
                    content = (tweet?.userMentions[indexPath.row].keyword)!
                    testCase = "usermention"
                    self.performSegueWithIdentifier("newTweetSearch", sender:indexPath)
            case "URLs":
                if let content = tweet?.urls[indexPath.row].keyword {
                    if let url = NSURL(string: content) {
                        UIApplication.sharedApplication().openURL(url)
                    }
                }
            case "Photos":
                if let url = tweet?.media[indexPath.row].url {
                    UIApplication.sharedApplication().openURL(url)
                }
        default: print("Click on case error: TweetDetailViewController")
        
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepare sender \(sender)" )
        
        if let svc = segue.destinationViewController as? TweetTableViewController {

            svc.searchText = content
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
