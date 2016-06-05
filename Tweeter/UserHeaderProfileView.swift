//
//  UserHeaderView.swift
//  Tweeter
//
//  Created by Yat Choi on 6/1/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

class UserHeaderProfileView: UIView {
  
  var bgImageView: UIImageView!
  var imageView: UIImageView!
  var nameLabel: UILabel!
  var usernameLabel: UILabel!
  
  var name: String? {
    get {
      return nameLabel?.text
    }
    set {
      nameLabel?.text = newValue
    }
  }
  
  var username: String? {
    get {
      return usernameLabel?.text
    }
    set {
      usernameLabel?.text = newValue
    }
  }
  
  var image: NSURL? {
    didSet {
      imageView?.setImageWithURL(image!)
    }
  }
  
  var bgImage: NSURL? {
    didSet {
      bgImageView?.setImageWithURL(bgImage!)
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
    bgImageView = UIImageView(frame: .zero)
    imageView = UIImageView(frame: .zero)
    nameLabel = UILabel(frame: .zero)
    usernameLabel = UILabel(frame: .zero)
    
    nameLabel.textColor = UIColor.whiteColor()
    
    usernameLabel.font = UIFont(name: "Helvetica", size: 15)
    usernameLabel.textColor = UIColor.whiteColor()
    
    let bgView = UIView(frame: .zero)
    bgView.backgroundColor = UIColor.blackColor()
    self.addSubview(bgView)
    
    bgView.translatesAutoresizingMaskIntoConstraints = false
    
    bgView.addSubview(bgImageView)
    bgView.addSubview(imageView)
    bgView.addSubview(nameLabel)
    bgView.addSubview(usernameLabel)
    
    // bgImageView
    bgImageView.translatesAutoresizingMaskIntoConstraints = false
    var bgImageConstraints = [NSLayoutConstraint]()
    
    bgImageConstraints.append(NSLayoutConstraint(item: bgView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
    bgImageConstraints.append(NSLayoutConstraint(item: bgView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
    bgImageConstraints.append(NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: bgView, attribute: .Trailing, multiplier: 1, constant: 0))
    bgImageConstraints.append(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: bgView, attribute: .Bottom, multiplier: 1, constant: 0))
    
    bgImageConstraints.append(NSLayoutConstraint(item: bgImageView, attribute: .Leading, relatedBy: .Equal, toItem: bgView, attribute: .Leading, multiplier: 1, constant: 0))
    bgImageConstraints.append(NSLayoutConstraint(item: bgImageView, attribute: .Top, relatedBy: .Equal, toItem: bgView, attribute: .Top, multiplier: 1, constant: 0))
    bgImageConstraints.append(NSLayoutConstraint(item: bgView, attribute: .Trailing, relatedBy: .Equal, toItem: bgImageView, attribute: .Trailing, multiplier: 1, constant: 0))
    bgImageConstraints.append(NSLayoutConstraint(item: bgView, attribute: .Bottom, relatedBy: .Equal, toItem: bgImageView, attribute: .Bottom, multiplier: 1, constant: 0))
    
    // ImageView dimension constraints
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: 64))
    imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: 64))
    
    let imageViewTop = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: bgView, attribute: .Top, multiplier: 1, constant: 20)
    let imageViewCenter = NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: bgView, attribute: .CenterX, multiplier: 1, constant: 0)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    let nameLabelLeading = NSLayoutConstraint(item: nameLabel, attribute: .CenterX, relatedBy: .Equal, toItem: bgView, attribute: .CenterX, multiplier: 1, constant: 0)
    let nameLabelTop = NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1, constant: 8)
    
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    let usernameLabelLeading = NSLayoutConstraint(item: usernameLabel, attribute: .CenterX, relatedBy: .Equal, toItem: bgView, attribute: .CenterX, multiplier: 1, constant: 0)
    let usernameLabelTop = NSLayoutConstraint(item: usernameLabel, attribute: .Top, relatedBy: .Equal, toItem: nameLabel, attribute: .Bottom, multiplier: 1, constant: 3)
    
    self.addConstraints(bgImageConstraints)
    self.addConstraints([imageViewTop, imageViewCenter, nameLabelLeading, nameLabelTop, usernameLabelLeading, usernameLabelTop])
  }
  
}
