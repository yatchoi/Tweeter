//
//  TweetViewController.swift
//  Tweeter
//
//  Created by Yat Choi on 6/1/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
  
  var tweet: Tweet!
  var userHeaderView: UserHeaderView!
  var tweetContentLabel: UILabel!
  var tweetTimestampLabel: UILabel!
  
  var tweetBarDelegate: TweetBarDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    let user = tweet!.user!
    
    // SETUP UI ELEMENTS
    
    // UserHeaderView
    userHeaderView = UserHeaderView(frame: .zero)
    userHeaderView.name = user.name!
    userHeaderView.username = "@\(user.screenname!)"
    userHeaderView.image = user.profileImageUrl!
    
    view.addSubview(userHeaderView)
    
    // Tweet Details
    setupTweetContentLabel()
    setupTimeStampLabel()
    
    view.addSubview(tweetContentLabel)
    view.addSubview(tweetTimestampLabel)
    
    let separator1 = addSeparator()
    
    let tweetCountBar = TweetCountBar()
    tweetCountBar.retweets = Int(tweet!.retweetCount!)
    tweetCountBar.favourites = Int(tweet!.favouritesCount!)
    view.addSubview(tweetCountBar)
    tweetCountBar.translatesAutoresizingMaskIntoConstraints = false
    
    let separator2 = addSeparator()
    
    let tweetBar = TweetBar()
    tweetBar.tweet = self.tweet!
    tweetBar.delegate = self.tweetBarDelegate
    view.addSubview(tweetBar)
    tweetBar.translatesAutoresizingMaskIntoConstraints = false
    
    let separator3 = addSeparator()
    
    // AUTOLAYOUT
    // UserHeaderView Constraints
    userHeaderView.translatesAutoresizingMaskIntoConstraints = false
//    userHeaderView.addConstraint(NSLayoutConstraint(item: userHeaderView, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
    let userHeaderViewLeft = NSLayoutConstraint(item: userHeaderView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
    let userHeaderViewRight = NSLayoutConstraint(item: userHeaderView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
    let userHeaderViewTop = NSLayoutConstraint(item: userHeaderView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 60)
    
    // Tweet Content Constraints
    tweetContentLabel.translatesAutoresizingMaskIntoConstraints = false
    tweetTimestampLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let tweetContentLeft = NSLayoutConstraint(item: tweetContentLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 8)
    let tweetContentRight = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: tweetContentLabel, attribute: .Trailing, multiplier: 1, constant: 8)
    let tweetContentTop = NSLayoutConstraint(item: tweetContentLabel, attribute: .Top, relatedBy: .Equal, toItem: userHeaderView, attribute: .Bottom, multiplier: 1, constant: 8)
    
    let tweetTimestampLeft = NSLayoutConstraint(item: tweetTimestampLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 8)
    let tweetTimestampRight = NSLayoutConstraint(item: tweetTimestampLabel, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 8)
    let tweetTimestampTop = NSLayoutConstraint(item: tweetTimestampLabel, attribute: .Top, relatedBy: .Equal, toItem: tweetContentLabel, attribute: .Bottom, multiplier: 1, constant: 8)
    
    // Separator constraints
    let horizontalTop = NSLayoutConstraint(item: separator1, attribute: .Top, relatedBy: .Equal, toItem: tweetTimestampLabel, attribute: .Bottom, multiplier: 1, constant: 14)
    let horizontalLeading = NSLayoutConstraint(item: separator1, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 8)
    let horizontalTrailing = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: separator1, attribute: .Trailing, multiplier: 1, constant: 8)
    
    // Tweet Count Bar Constraints
    let tweetCountBarLeft = NSLayoutConstraint(item: tweetCountBar, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
    let tweetCountBarRight = NSLayoutConstraint(item: tweetCountBar, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
    let tweetCountBarTop = NSLayoutConstraint(item: tweetCountBar, attribute: .Top, relatedBy: .Equal, toItem: separator1, attribute: .Bottom, multiplier: 1, constant: 5)
    
    // Separator constraints
    let horizontal2Top = NSLayoutConstraint(item: separator2, attribute: .Top, relatedBy: .Equal, toItem: tweetCountBar, attribute: .Bottom, multiplier: 1, constant: 6)
    let horizontal2Leading = NSLayoutConstraint(item: separator2, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 8)
    let horizontal2Trailing = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: separator2, attribute: .Trailing, multiplier: 1, constant: 8)
    
    // Tweet Bar Constraints
    let tweetBarLeft = NSLayoutConstraint(item: tweetBar, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 16)
    let tweetBarRight = NSLayoutConstraint(item: tweetBar, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
    let tweetBarTop = NSLayoutConstraint(item: tweetBar, attribute: .Top, relatedBy: .Equal, toItem: separator2, attribute: .Bottom, multiplier: 1, constant: 0)
    
    // Separator constraints
    let horizontal3Top = NSLayoutConstraint(item: separator3, attribute: .Top, relatedBy: .Equal, toItem: tweetBar, attribute: .Bottom, multiplier: 1, constant: 0)
    let horizontal3Leading = NSLayoutConstraint(item: separator3, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 8)
    let horizontal3Trailing = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: separator3, attribute: .Trailing, multiplier: 1, constant: 8)
    
    view.addConstraints([userHeaderViewLeft,
                         userHeaderViewTop,
                         userHeaderViewRight,
                         tweetContentLeft,
                         tweetContentRight,
                         tweetContentTop,
                         tweetTimestampLeft,
                         tweetTimestampRight,
                         tweetTimestampTop, horizontalTop, horizontalLeading, horizontalTrailing,
                         tweetCountBarTop,
                         tweetCountBarLeft,
                         tweetCountBarRight,
                         horizontal2Top, horizontal2Leading, horizontal2Trailing,
                         tweetBarTop,
                         tweetBarLeft,
                         tweetBarRight, horizontal3Top, horizontal3Leading, horizontal3Trailing])
  }
  
  func setupTweetContentLabel() {
    tweetContentLabel = UILabel(frame: .zero)
    tweetContentLabel.numberOfLines = 0
    tweetContentLabel.text = tweet?.text!
    tweetContentLabel.font = UIFont(name: "Helvetica", size: 14)
  }
  
  func setupTimeStampLabel() {
    tweetTimestampLabel = UILabel(frame: .zero)
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    tweetTimestampLabel.text = dateFormatter.stringFromDate(tweet.createdAtDate!)
    tweetTimestampLabel.font = UIFont(name: "Helvetica", size: 14)
    tweetTimestampLabel.textColor = UIColor(red: 117/255.0, green: 117/255.0, blue: 117/255.0, alpha: 1)
  }
  
  func setupTweetCountBar() -> TweetCountBar {
    let tweetCountBar = TweetCountBar()
    tweetCountBar.retweets = Int(tweet!.retweetCount!)
    tweetCountBar.favourites = Int(tweet!.favouritesCount!)
    view.addSubview(tweetCountBar)
    
    tweetCountBar.translatesAutoresizingMaskIntoConstraints = false
    
    return tweetCountBar
  }
  
  func addSeparator() -> UIView {
    let horizontalRule = UIView(frame: .zero)
    horizontalRule.backgroundColor = UIColor(red: 117/255.0, green: 117/255.0, blue: 117/255.0, alpha: 0.5)
    view.addSubview(horizontalRule)
    horizontalRule.translatesAutoresizingMaskIntoConstraints = false
    
    horizontalRule.addConstraint(NSLayoutConstraint(item: horizontalRule, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 0.5, constant: 1))
    
    return horizontalRule
  }
}
