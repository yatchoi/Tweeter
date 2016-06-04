//
//  TweetBar.swift
//  Tweeter
//
//  Created by Yat Choi on 6/2/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

protocol TweetBarDelegate: class {
  func tweetBar(tweetBar: TweetBar, didTapReply username: String)
}

class TweetBar: UIView {

  var replyButton = UIButton(frame: .zero)
  var retweetButton = UIButton(frame: .zero)
  var favouriteButton = UIButton(frame: .zero)
  
  var delegate: TweetBarDelegate?
  
  var tweet: Tweet! {
    didSet {
      if tweet.retweeted! {
        retweetButton.setImage(UIImage(named: "RetweetOn"), forState: .Normal)
      }
      else {
        retweetButton.setImage(UIImage(named: "RetweetIcon"), forState: .Normal)
      }
      
      if tweet.favourited! {
        favouriteButton.setImage(UIImage(named: "FavouriteOn"), forState: .Normal)
      }
      else {
        favouriteButton.setImage(UIImage(named: "FavouriteIcon"), forState: .Normal)
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    initSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    initSubviews()
  }
  
  func onReplyPressed(sender: UIButton) {
    self.delegate?.tweetBar(self, didTapReply: tweet.user!.screenname!)
  }
  
  func onRetweetPressed(sender: UIButton) {
    TwitterClient.sharedInstance.retweet(tweet.id!, success: { (tweet: Tweet) in
      print("successfully retweeted")
      self.tweet = tweet
    }) { (error:NSError) in
      print("Error trying to retweet: \(error)")
    }
  }
  
  func onFavouritePressed(sender: UIButton) {
    TwitterClient.sharedInstance.favourite(tweet.id!, success: { (tweet: Tweet) in
      print("successfully favourited")
      self.tweet = tweet
    }) { (error:NSError) in
      print("Error trying to retweet: \(error)")
    }
  }
  
  func initSubviews() {
    replyButton.setImage(UIImage(named: "ReplyIcon"), forState: .Normal)
    retweetButton.setImage(UIImage(named: "RetweetIcon"), forState: .Normal)
    favouriteButton.setImage(UIImage(named: "FavouriteIcon"), forState: .Normal)
    
    retweetButton.addTarget(self, action: #selector(TweetBar.onRetweetPressed(_:)), forControlEvents: .TouchUpInside)
    favouriteButton.addTarget(self, action: #selector(TweetBar.onFavouritePressed(_:)), forControlEvents: .TouchUpInside)
    replyButton.addTarget(self, action: #selector(TweetBar.onReplyPressed(_:)), forControlEvents: .TouchUpInside)
    
    self.addSubview(replyButton)
    self.addSubview(retweetButton)
    self.addSubview(favouriteButton)
    
    replyButton.translatesAutoresizingMaskIntoConstraints = false
    retweetButton.translatesAutoresizingMaskIntoConstraints = false
    favouriteButton.translatesAutoresizingMaskIntoConstraints = false
    
    replyButton.addConstraint(NSLayoutConstraint(item: replyButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 24))
    replyButton.addConstraint(NSLayoutConstraint(item: replyButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 24))
    retweetButton.addConstraint(NSLayoutConstraint(item: retweetButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 24))
    retweetButton.addConstraint(NSLayoutConstraint(item: retweetButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 24))
    favouriteButton.addConstraint(NSLayoutConstraint(item: favouriteButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 24))
    favouriteButton.addConstraint(NSLayoutConstraint(item: favouriteButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 24))
    
    var constraints = [NSLayoutConstraint]()
    
    // Reply Button
    constraints.append(NSLayoutConstraint(item: replyButton, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 8))
    constraints.append(NSLayoutConstraint(item: replyButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8))
    constraints.append(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: replyButton, attribute: .Bottom, multiplier: 1, constant: 8))
    
    // Retweet Button
    constraints.append(NSLayoutConstraint(item: retweetButton, attribute: .Leading, relatedBy: .Equal, toItem: replyButton, attribute: .Trailing, multiplier: 1, constant: 64))
    constraints.append(NSLayoutConstraint(item: retweetButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8))
    
    // favourite button
    constraints.append(NSLayoutConstraint(item: favouriteButton, attribute: .Leading, relatedBy: .Equal, toItem: retweetButton, attribute: .Trailing, multiplier: 1, constant: 64))
    constraints.append(NSLayoutConstraint(item: favouriteButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8))
    
    self.addConstraints(constraints)
  }

}
