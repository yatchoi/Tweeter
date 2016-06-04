//
//  TweetCell.swift
//  Tweeter
//
//  Created by Yat Choi on 6/1/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit
import AFNetworking

protocol TweetCellDelegate: class {
  func tweetCell(tweetCell: TweetCell, didTapUserProfile username: String)
}

class TweetCell: UITableViewCell {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var timeSinceLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  
  let dateFormatter = NSDateFormatter()
  let twitterDateFormatter = NSDateFormatter()
  
  var tweet: Tweet?
  var delegate: TweetCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    dateFormatter.dateStyle = .ShortStyle
    dateFormatter.timeStyle = .ShortStyle
    
    twitterDateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
    
    let profileTapRecognizer = UITapGestureRecognizer(target: self, action: "profileImageTapped:")
    profileTapRecognizer.numberOfTapsRequired = 1
    profileImageView.userInteractionEnabled = true
    profileImageView.addGestureRecognizer(profileTapRecognizer)
  }
  
  func populateWithTweet(tweet: Tweet?) {
    if tweet != nil {
      self.tweet = tweet
      self.profileImageView.setImageWithURL((tweet!.user?.profileImageUrl!)!)
      self.fullNameLabel.text = tweet!.user?.name!
      self.usernameLabel.text = "@\(tweet!.user!.screenname!)"
      self.contentLabel.text = tweet!.text!
      self.timeSinceLabel.text = getTimestamp(tweet!.createdAt!)
    }
  }
  
  func getTimestamp(time: String) -> String {
    let date = twitterDateFormatter.dateFromString(time)
    return dateFormatter.stringFromDate(date!)
  }
  
  func profileImageTapped(sender: AnyObject) {
    self.delegate?.tweetCell(self, didTapUserProfile: self.tweet!.user!.screenname!)
  }
}
