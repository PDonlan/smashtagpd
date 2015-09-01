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
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        
        // load new information from our tweet if any
        

        
        if let tweet = self.tweet
        {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for index in tweet.media {                  //for loop is here Mr MaGoo
                    println("index = /index")
                    var label = tweetTextLabel
                    var text = NSMutableAttributedString(attributedString: label.attributedText)
                    text.addAttribute(NSForegroundColorAttributeName, value:UIColor.redColor(), range:NSRange(location: 0, length: 4))
                    text.addAttribute(NSForegroundColorAttributeName, value:UIColor.greenColor(), range:NSRange(location:4, length: 4))
                    label.attributedText = text
//                    label.attributedText = tweet.text
                    tweetTextLabel = label
 //                   tweetTextLabel.text! += " break"
                }
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
