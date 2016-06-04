//
//  ComposeViewController.swift
//  Tweeter
//
//  Created by Yat Choi on 6/1/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

protocol ComposeViewDelegate: class {
  func composeView(composeView: ComposeViewController, didSubmitTweet status: String)
  func didCancel(composeView: ComposeViewController)
}

class ComposeViewController: UIViewController {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var textAreaView: UITextView!
  
  var usernameForReply: String?
  var delegate: ComposeViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let user = User.currentUser!
    
    // Nav setup
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(ComposeViewController.cancelButtonTapped))
    navigationItem.leftBarButtonItem = cancelButton
    
    let tweetButton = UIBarButtonItem(title: "Reply", style: .Plain, target: self, action: #selector(ComposeViewController.tweetButtonTapped))
    navigationItem.rightBarButtonItem = tweetButton

    self.profileImageView.setImageWithURL(user.profileImageUrl!)
    self.fullNameLabel.text = user.name!
    self.usernameLabel.text = "@\(user.screenname!)"
    
    if (usernameForReply != nil) {
      self.textAreaView.text = "@\(usernameForReply!) "
    }
    
    self.textAreaView.becomeFirstResponder()
  }
  
  func cancelButtonTapped() {
    self.delegate?.didCancel(self)
  }
  
  func tweetButtonTapped() {
    self.delegate?.composeView(self, didSubmitTweet: textAreaView.text)
  }
}
