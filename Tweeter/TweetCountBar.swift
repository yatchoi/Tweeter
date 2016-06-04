//
//  TweetCountBar.swift
//  Tweeter
//
//  Created by Yat Choi on 6/2/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

class TweetCountBar: UIView {
  
  var retweetCountLabel: UILabel!
  var favouriteCountLabel: UILabel!
  
  var retweets: Int? {
    get {
      return Int(retweetCountLabel.text!)
    }
    set {
      retweetCountLabel.text = String(newValue!)
    }
  }
  
  var favourites: Int? {
    get {
      return Int(favouriteCountLabel.text!)
    }
    set {
      favouriteCountLabel.text = String(newValue!)
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
  
  func initSubviews() {
    retweetCountLabel = UILabel(frame: .zero)
    retweetCountLabel.font = UIFont(name: "Helvetica", size: 12)
    favouriteCountLabel = UILabel(frame: .zero)
    favouriteCountLabel.font = UIFont(name: "Helvetica", size: 12)
    
    let retweetsLabel = UILabel(frame: .zero)
    retweetsLabel.text = "RETWEETS"
    retweetsLabel.font = UIFont(name: "Helvetica", size: 12)
    retweetsLabel.textColor = UIColor(red: 117/255.0, green: 117/255.0, blue: 117/255.0, alpha: 1)
    let favouritesLabel = UILabel(frame: .zero)
    favouritesLabel.text = "FAVOURITES"
    favouritesLabel.font = UIFont(name: "Helvetica", size: 12)
    favouritesLabel.textColor = UIColor(red: 117/255.0, green: 117/255.0, blue: 117/255.0, alpha: 1)
    
    self.addSubview(retweetCountLabel)
    self.addSubview(retweetsLabel)
    self.addSubview(favouriteCountLabel)
    self.addSubview(favouritesLabel)
    
    retweetCountLabel.translatesAutoresizingMaskIntoConstraints = false
    favouriteCountLabel.translatesAutoresizingMaskIntoConstraints = false
    retweetsLabel.translatesAutoresizingMaskIntoConstraints = false
    favouritesLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let retweetCountLeading = NSLayoutConstraint(item: retweetCountLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 8)
    let retweetCountTop = NSLayoutConstraint(item: retweetCountLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8)
    let retweetCountBottom = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: retweetCountLabel, attribute: .Bottom, multiplier: 1, constant: 8)
    
    let retweetsLabelLeading = NSLayoutConstraint(item: retweetsLabel, attribute: .Leading, relatedBy: .Equal, toItem: retweetCountLabel, attribute: .Trailing, multiplier: 1, constant: 8)
    let retweetsLabelTop = NSLayoutConstraint(item: retweetsLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8)
    
    let favouriteCountLeading = NSLayoutConstraint(item: favouriteCountLabel, attribute: .Leading, relatedBy: .Equal, toItem: retweetsLabel, attribute: .Trailing, multiplier: 1, constant: 8)
    let favouriteCountTop = NSLayoutConstraint(item: favouriteCountLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8)
    
    let favouriteLabelLeading = NSLayoutConstraint(item: favouritesLabel, attribute: .Leading, relatedBy: .Equal, toItem: favouriteCountLabel, attribute: .Trailing, multiplier: 1, constant: 8)
    let favouriteLabelTop = NSLayoutConstraint(item: favouritesLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8)
    let favouriteLabelTrailing = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .GreaterThanOrEqual, toItem: favouritesLabel, attribute: .Trailing, multiplier: 1, constant: 8)
    
    self.addConstraints([retweetCountLeading, retweetCountTop, retweetCountBottom, retweetsLabelLeading, retweetsLabelTop, favouriteCountLeading, favouriteCountTop, favouriteLabelLeading, favouriteLabelTop, favouriteLabelTrailing])
  }
}
