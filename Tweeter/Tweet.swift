//
//  Tweet.swift
//  Tweeter
//
//  Created by Yat Choi on 5/31/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import Foundation

class Tweet: NSObject {
  var id: NSNumber?
  var user: User?
  var text: String?
  var createdAt: String?
  var createdAtDate: NSDate?
  var retweetCount: NSNumber?
  var retweeted: Bool?
  var favouritesCount: NSNumber?
  var favourited: Bool?

  var dateFormatter = NSDateFormatter()
  
  init(dictionary: NSDictionary) {
    if let tweetId = dictionary["id"] {
      self.id = tweetId as? NSNumber
    }
    
    if let user = dictionary["user"] {
      self.user = User(dictionary: user as! NSDictionary)
    }
    
    if let text = dictionary["text"] {
      self.text = text as? String
    }
    
    if let createdAt = dictionary["created_at"] {
      dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
      self.createdAt = createdAt as? String
      self.createdAtDate = dateFormatter.dateFromString(createdAt as! String)
    }
    
    if let retweetCount = dictionary["retweet_count"] {
      self.retweetCount = retweetCount as? NSNumber
    } else {
      self.retweetCount = 0
    }
    
    if let favouritesCount = dictionary["favorite_count"] {
      self.favouritesCount = favouritesCount as? NSNumber
    } else {
      self.favouritesCount = 0
    }
    
    if let retweeted = dictionary["retweeted"] {
      self.retweeted = retweeted as? Bool
    } else {
      self.retweeted = false
    }
    
    if let favourited = dictionary["favorited"] {
      self.favourited = favourited as? Bool
    } else {
      self.favourited = false
    }
  }
}