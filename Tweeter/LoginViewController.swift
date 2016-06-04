//
//  LoginViewController.swift
//  Tweeter
//
//  Created by Yat Choi on 5/31/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
  
  let TwitterConsumerKey = "wvGpUZhxWngf2r199sjN4BTWC"
  let TwitterConsumerSecret = "9zs83FKfiUajqC2MAexovpGyyJpXGlBjA8wnWjchM9gpILncKt"

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }
  
  func navigateToTimeline() {
    let vc = MainViewController()
    self.navigationController?.pushViewController(vc, animated: false)
    self.navigationController?.navigationBar.hidden = true
    self.navigationController?.interactivePopGestureRecognizer?.enabled = false
  }

  @IBAction func onLoginTapped(sender: AnyObject) {
    TwitterClient.sharedInstance.login({
      print("I've logged in!")
      self.navigateToTimeline()
    }) { (error: NSError) in
      print("Got an error: \(error.description)")
    }
  }
}
