//
//  User.swift
//  Tweeter
//
//  Created by Yat Choi on 5/31/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import Foundation

class User: NSObject {
  var name: String?
  var screenname: String?
  var profileImageUrl: NSURL?
  var profileBackgroundImageUrl: NSURL?
  var favouritesCount: Int?
  var followersCount: Int?
  var friendsCount: Int?
  var statusesCount: Int?
  
  var dictionary: NSDictionary?
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    
    if let name = dictionary["name"] {
      self.name = name as? String
    }
    
    if let screenname = dictionary["screen_name"] {
      self.screenname = screenname as? String
    }
    
    if let profileImageUrl = dictionary["profile_image_url_https"] {
      self.profileImageUrl = NSURL(string: profileImageUrl as! String)
    }
    
    if let profileBackgroundImageUrl = dictionary["profile_background_image_url_https"] as? String {
      self.profileBackgroundImageUrl = NSURL(string: profileBackgroundImageUrl)
    }
    
    if let followersCount = dictionary["followers_count"] {
      self.followersCount = followersCount as? Int
    } else {
      self.followersCount = 0
    }
    
    if let friendsCount = dictionary["friends_count"] {
      self.friendsCount = friendsCount as? Int
    } else {
      self.friendsCount = 0
    }
    
    if let statusesCount = dictionary["statuses_count"] {
      self.statusesCount = statusesCount as? Int
    } else {
      self.statusesCount = 0
    }
  }
  
  static var _currentUser: User?
  class var currentUser: User? {
    get {
      if _currentUser == nil {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let userData = defaults.objectForKey("currentUserJson") as? NSData
        
        if let userData = userData {
          let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
          
          _currentUser = User(dictionary: dictionary)
        }
      }
      return _currentUser
    }
    
    set(user) {
      _currentUser = user
      let defaults = NSUserDefaults.standardUserDefaults()
      if let user = user {
        let json = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
        
        defaults.setObject(json, forKey: "currentUserJson")
      } else {
        defaults.setObject(nil, forKey: "currentUserJson")
      }
      defaults.synchronize()
    }
  }
}
