//
//  DetailTweetViewController.swift
//  smashtagpd
//
//  Created by Paul Donlan on 10/4/15.
//  Copyright © 2015 Paul Donlan. All rights reserved.
//

import UIKit

class TweetDetailView: UITableViewCell {
    
    var tweet:Tweet

    @IBOutlet weak var tweetImages: TweetDetailView! {
        if let tweetImages = tweet.media {
            
        }
    }

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        
//        return tweets[media].count
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return tweets[section].count
//    }

    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
