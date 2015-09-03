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
    
    
    func updateUI() {                               //write out tweets
//        println(tweet)
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
//        println("updateUI called")
        
        // load new information from our tweet if any
        
        if let tweet = self.tweet
        {
            tweetTextLabel?.text = tweet.text
            var label = tweetTextLabel
            var text = NSMutableAttributedString(attributedString: label.attributedText)
            if tweetTextLabel?.text != nil {
                for index in tweet.hashtags {                  //for loop are here Mr MaGoo
                    text.addAttribute(NSForegroundColorAttributeName, value:UIColor.redColor(), range:NSRange(location: 0, length: 2))
                    text.addAttribute(NSForegroundColorAttributeName, value:UIColor.greenColor(), range:NSRange(location:2, length: 2))
                }
                for index in tweet.userMentions {                  
                    text.addAttribute(NSForegroundColorAttributeName, value:UIColor.redColor(), range:NSRange(location: 0, length: 2))
                    text.addAttribute(NSForegroundColorAttributeName, value:UIColor.greenColor(), range:NSRange(location:2, length: 2))
                }
                label.attributedText = text
                tweetTextLabel = label
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"  //tweet user description
            
            if let profileImageURL = tweet.user.profileImageURL {           //blocks main thread todo: fix
                if let imageData = NSData(contentsOfURL: profileImageURL)
                {
                    tweetProfileImageView?.image = UIImage(data: imageData)
                    
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
