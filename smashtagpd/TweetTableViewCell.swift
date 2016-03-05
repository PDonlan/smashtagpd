//
//  TweetTableViewCell.swift
//  smashtagpd
//
//  Created by Paul Donlan on 8/23/15.
//  Copyright (c) 2015 Paul Donlan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    
    @IBOutlet weak var tweetScreenNameLabel: UILabel!

    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var tweetImageView: UIImageView!
    
    func updateUI() {                               //write out tweets
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetImageView?.image = nil
      
        // load new information from our tweet if any
        if let tweet = self.tweet
        {
            tweetTextLabel?.text = tweet.text
            let text = NSMutableAttributedString(attributedString: tweetTextLabel.attributedText!)
            for index in tweet.hashtags {
                text.addAttribute(NSForegroundColorAttributeName, value:UIColor.greenColor(), range:index.nsrange)
            }
            for index in tweet.userMentions {
                text.addAttribute(NSForegroundColorAttributeName, value:UIColor.redColor(), range:index.nsrange)
            }
            for index in tweet.urls {
                text.addAttribute(NSForegroundColorAttributeName, value:UIColor.blueColor(), range:index.nsrange)
            }
            tweetTextLabel.attributedText = text
            tweetScreenNameLabel?.text = "\(tweet.user)"  //tweet user description
            
            if let profileImageURL = tweet.user.profileImageURL {
        //blocks main thread todo: fix
                if let imageData = NSData(contentsOfURL: profileImageURL)
                {
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            
            }
            for item in tweet.media {
//                print("tweet media = ", item.url)

        //blocks main thread todo: fix
                if let imageData = NSData(contentsOfURL: item.url)
                {
                    tweetImageView?.image = UIImage(data: imageData)
                }
            }
//            let formatter = NSDateFormatter()
//            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
//                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
//            } else {
//                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
//            }
//            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }
    }
    
}
