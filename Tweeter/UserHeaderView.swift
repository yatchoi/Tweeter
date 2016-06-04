//
//  UserHeaderView.swift
//  Tweeter
//
//  Created by Yat Choi on 6/1/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

class UserHeaderView: UIView {

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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    initSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    initSubviews()
  }
  
  func initSubviews() {
    imageView = UIImageView(frame: .zero)
    nameLabel = UILabel(frame: .zero)
    usernameLabel = UILabel(frame: .zero)
    
    usernameLabel.font = UIFont(name: "Helvetica", size: 15)
    usernameLabel.textColor = UIColor(red: 117/255.0, green: 117/255.0, blue: 117/255.0, alpha: 1)
    
    let bgView = UIView()
    bgView.backgroundColor = UIColor.redColor()
    self.addSubview(bgView)
    
    bgView.addSubview(imageView)
    bgView.addSubview(nameLabel)
    bgView.addSubview(usernameLabel)
    
    // ImageView dimension constraints
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: 64))
    imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: 64))
    
    let imageViewLeading = NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: bgView, attribute: .Leading, multiplier: 1, constant: 8)
    let imageViewTop = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: bgView, attribute: .Top, multiplier: 1, constant: 8)
    let imageViewBottom = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1, constant: 8)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    let nameLabelLeading = NSLayoutConstraint(item: nameLabel, attribute: .Leading, relatedBy: .Equal, toItem: imageView, attribute: .Trailing, multiplier: 1, constant: 8)
    let nameLabelTrailing = NSLayoutConstraint(item: nameLabel, attribute: .Trailing, relatedBy: .GreaterThanOrEqual, toItem: bgView, attribute: .Trailing, multiplier: 1, constant: 8)
    let nameLabelTop = NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: .Equal, toItem: bgView, attribute: .Top, multiplier: 1, constant: 17)
    
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    let usernameLabelLeading = NSLayoutConstraint(item: usernameLabel, attribute: .Leading, relatedBy: .Equal, toItem: imageView, attribute: .Trailing, multiplier: 1, constant: 8)
    let usernameLabelTrailing = NSLayoutConstraint(item: usernameLabel, attribute: .Trailing, relatedBy: .GreaterThanOrEqual, toItem: bgView, attribute: .Trailing, multiplier: 1, constant: 8)
    let usernameLabelTop = NSLayoutConstraint(item: usernameLabel, attribute: .Top, relatedBy: .Equal, toItem: nameLabel, attribute: .Bottom, multiplier: 1, constant: 3)
    
    self.addConstraints([imageViewLeading, imageViewTop, imageViewBottom, nameLabelLeading, nameLabelTrailing, nameLabelTop, usernameLabelLeading, usernameLabelTrailing, usernameLabelTop])
  }

}
