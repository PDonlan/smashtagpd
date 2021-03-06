//
//  TweetTableViewController.swift
//  smashtagpd
//
//  Created by Paul Donlan on 8/14/15.
//  Copyright (c) 2015 Paul Donlan. All rights reserved.
//
//  Wombat!
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate
{

    var tweets = [[Tweet]]()  //array of arrays
//    var tweetHistory:String?     // history of tweets
    var searchText: String? = "#stanford" {
        didSet {    //with new tweet search
//            tweetHistory.append(lastSuccessfulRequest)  //todo: populate history of tweets
            lastSuccessfulRequest = nil  //reset last successfull tweet
            searchTextField?.text = searchText
            tweets.removeAll()   // clear out table of old tweets
            tableView.reloadData()

            refresh()
        }
    }
    
     // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension //calculate size
        refresh()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    var lastSuccessfulRequest: TwitterRequest?
    
    var nextRequestToAttempt: TwitterRequest?
        {
            if lastSuccessfulRequest == nil {
                if searchText != nil {
                    return TwitterRequest(search: searchText!, count:100)
                } else {
                    return nil
                }
            } else {
                return lastSuccessfulRequest!.requestForNewer
            }
        }
    
    
    func refresh() {
        refreshControl?.beginRefreshing()
        if searchText != nil {
            if let request = nextRequestToAttempt {         //fetch new tweets and refresh UI
                request.fetchTweets {newTweets in
                    
                    dispatch_async(dispatch_get_main_queue()){
                        if newTweets.count > 0
                        {   self.lastSuccessfulRequest = request
                            self.tweets.insert(newTweets, atIndex: 0)
                            self.tableView.reloadData()
                        }
                        self.refreshControl?.endRefreshing()
                    }
                }
            }
        } else {
            refreshControl?.endRefreshing()
        }
        

    }

    @IBAction func refresh(sender: UIRefreshControl) {     //refresh UI
        refresh()
        
    }
 
    @IBOutlet weak var searchTextField: UITextField! {     //UI action for new tweet search
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
            
        }        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()            // close keyboard view
            searchText = textField.text
        }
        return true
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tweets[section].count
    }

    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell

        // Configure the cell... tweets is the model

        cell.tweet = tweets[indexPath.section][indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print(segue.identifier)
        
        if let dtvc = segue.destinationViewController as? TweetDetailTableViewController {

            if let cell = sender as? TweetTableViewCell {

//                print(cell.tweet)
                dtvc.tweet = cell.tweet
            }
            
                        // Pass the selected object to the new view controller.
        
        }

    }


}
