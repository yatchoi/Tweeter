//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Yat Choi on 6/3/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

  @IBOutlet weak var headerViewContainer: UIView!
  @IBOutlet weak var tweetCount: UILabel!
  @IBOutlet weak var followingCount: UILabel!
  @IBOutlet weak var followersCount: UILabel!
  var userHeaderView: UserHeaderProfileView!
  
  var usernameToQuery: String!
  var user: User!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userHeaderView = UserHeaderProfileView(frame: headerViewContainer.frame)
    userHeaderView.name = user.name!
    userHeaderView.username = "@\(user.screenname!)"
    userHeaderView.image = user.profileImageUrl!
    if (user.profileBackgroundImageUrl != nil) {
      userHeaderView.bgImage = user.profileBackgroundImageUrl
    }

    headerViewContainer.addSubview(userHeaderView)
    
    userHeaderView.translatesAutoresizingMaskIntoConstraints = false
    
    let userHeaderViewLeft = NSLayoutConstraint(item: userHeaderView, attribute: .Leading, relatedBy: .Equal, toItem: headerViewContainer, attribute: .Leading, multiplier: 1, constant: 0)
    let userHeaderViewRight = NSLayoutConstraint(item: userHeaderView, attribute: .Trailing, relatedBy: .Equal, toItem: headerViewContainer, attribute: .Trailing, multiplier: 1, constant: 0)
    let userHeaderViewTop = NSLayoutConstraint(item: userHeaderView, attribute: .Top, relatedBy: .Equal, toItem: headerViewContainer, attribute: .Top, multiplier: 1, constant: 60)
    let userHeaderViewBottom = NSLayoutConstraint(item: headerViewContainer, attribute: .Bottom, relatedBy: .Equal, toItem: userHeaderView, attribute: .Bottom, multiplier: 1, constant: 0)
    
    headerViewContainer.addConstraints([userHeaderViewLeft, userHeaderViewRight, userHeaderViewTop, userHeaderViewBottom])

    // Do any additional setup after loading the view.
    if (usernameToQuery != nil) {
      TwitterClient.sharedInstance.userByScreenname(usernameToQuery, success: { (user: User) in
        self.user = user
        self.populateFields()
      }) { (error: NSError) in
        print("Error getting user: \(error.description)")
      }
    } else {
     self.populateFields()
    }
  }

  func populateFields() {
    tweetCount.text = String(user.statusesCount!)
    followingCount.text = String(user.friendsCount!)
    followersCount.text = String(user.followersCount!)
  }
}
