//
//  MainViewController.swift
//  Tweeter
//
//  Created by Yat Choi on 6/4/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
  
  var viewControllers: [UIViewController]!
  
  var menuViewController: MenuViewController! {
    didSet {
      view.layoutIfNeeded()
      menuView.addSubview(menuViewController.view)
    }
  }
  
  var contentViewController: UIViewController! {
    didSet {
      view.layoutIfNeeded()
      contentView.addSubview(contentViewController.view)
    }
  }
  
  var originalLeftMargin: CGFloat!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.menuViewController = MenuViewController()
    menuViewController.delegate = self
    
    let tvc = TimelineViewController()
    let nvc = UINavigationController(rootViewController: tvc)
    
    let pvc = ProfileViewController()
    pvc.user = User.currentUser
    let nvc2 = UINavigationController(rootViewController: pvc)
    nvc2.navigationBar.barTintColor = UIColor(red: 125.0/255.0, green: 225.0/255.0, blue: 255.0/255.0, alpha: 1)
    
    let signOutButton = UIBarButtonItem(title: "Sign Out", style: .Plain, target: self, action: #selector(MainViewController.signOutTapped))
    signOutButton.tintColor = UIColor.whiteColor()
    pvc.navigationItem.leftBarButtonItem = signOutButton
    
    pvc.navigationItem.title = "Me"
    
    viewControllers = [nvc2, nvc]
    self.contentViewController = viewControllers[1]
    // Do any additional setup after loading the view.
  }
  
  func signOutTapped() {
    TwitterClient.sharedInstance.logout()
  }

  @IBAction func onContentPanned(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(view)
    let velocity = sender.velocityInView(view)
    
    if sender.state == UIGestureRecognizerState.Began {
      originalLeftMargin = leftMarginConstraint.constant
    } else if sender.state == UIGestureRecognizerState.Changed {
      if !(velocity.x < 0 && leftMarginConstraint.constant == 0) {
        leftMarginConstraint.constant = originalLeftMargin + translation.x
      }
    } else if sender.state == UIGestureRecognizerState.Ended {
      if leftMarginConstraint.constant > (view.frame.width / 2) {
        leftMarginConstraint.constant = view.frame.width - 50
      } else {
        leftMarginConstraint.constant = 0
      }
      self.view.layoutIfNeeded()
    }
  }
  
  func animateCloseMenu() {
    view.layoutIfNeeded()
    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: .TransitionNone, animations: {
      self.view.layoutIfNeeded()
      self.leftMarginConstraint.constant = 0
      }, completion: nil)
  }
}


extension MainViewController: MenuViewDelegate {
  func menuView(menuView: MenuViewController, didSelectIndexAtRow indexPath: NSIndexPath) {
    self.contentViewController = viewControllers[indexPath.row]
    animateCloseMenu()
  }
}
