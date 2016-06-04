//
//  TimelineViewController.swift
//  Tweeter
//
//  Created by Yat Choi on 5/31/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

  @IBOutlet weak var timelineTable: UITableView!
  
  var tweets: [Tweet]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populateTweets(nil)
    
    // Nav setup
    self.navigationController?.navigationBar.barTintColor = UIColor(red: 125.0/255.0, green: 225.0/255.0, blue: 255.0/255.0, alpha: 1)
    
    let newButton = UIBarButtonItem(title: "New", style: .Plain, target: self, action: #selector(TimelineViewController.newButtonTapped))
    newButton.tintColor = UIColor.whiteColor()
    navigationItem.rightBarButtonItem = newButton
    
    let signOutButton = UIBarButtonItem(title: "Sign Out", style: .Plain, target: self, action: #selector(TimelineViewController.signOutTapped))
    signOutButton.tintColor = UIColor.whiteColor()
    navigationItem.leftBarButtonItem = signOutButton
    
    // Table setup
    timelineTable.dataSource = self
    timelineTable.delegate = self
    timelineTable.estimatedRowHeight = 100
    timelineTable.rowHeight = UITableViewAutomaticDimension
    
    let tweetCellNib = UINib(nibName: "TweetCell", bundle: nil)
    self.timelineTable.registerNib(tweetCellNib, forCellReuseIdentifier: "tweetCell")
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(TimelineViewController.populateTweets), forControlEvents: .ValueChanged)
    timelineTable.insertSubview(refreshControl, atIndex: 0)
  }
  
  func populateTweets(refreshControl: UIRefreshControl?) {
    TwitterClient.sharedInstance.fetchHomeTimeline({ (tweets: [Tweet]) in
      self.tweets = tweets
      self.timelineTable.reloadData()
      refreshControl?.endRefreshing()
    }) { (error: NSError) in
      print("Error getting tweets: \(error.description)")
    }
  }
  
  func newButtonTapped() {
    let vc = ComposeViewController()
    vc.delegate = self
    self.navigationController?.pushViewController(vc, animated: false)
  }

  func signOutTapped() {
    TwitterClient.sharedInstance.logout()
  }
}

extension TimelineViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets?.count ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = timelineTable.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
    cell.populateWithTweet(tweets[indexPath.row])
    cell.delegate = self
    return cell
  }
}

extension TimelineViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let vc = TweetViewController()
    vc.tweet = tweets[indexPath.row]
    vc.tweetBarDelegate = self
    self.navigationController?.pushViewController(vc, animated: false)
  }
}

extension TimelineViewController: TweetCellDelegate {
  func tweetCell(tweetCell: TweetCell, didTapUserProfile username: String) {
    let vc = ProfileViewController()
    vc.user = tweetCell.tweet?.user
    vc.usernameToQuery = username
    self.navigationController?.pushViewController(vc, animated: false)
  }
}

extension TimelineViewController: ComposeViewDelegate {
  func composeView(composeView: ComposeViewController, didSubmitTweet status: String) {
    TwitterClient.sharedInstance.postTweet(status, inReplyTo: nil, success: { (tweet: Tweet) in
      self.tweets.insert(tweet, atIndex: 0)
      self.timelineTable.reloadData()
    }) { (error:NSError) in
      print("Error: \(error.description)")
    }
    
    self.navigationController?.popViewControllerAnimated(false)
  }
  
  func didCancel(composeView: ComposeViewController) {
    self.navigationController?.popViewControllerAnimated(false)
  }
}

extension TimelineViewController: TweetBarDelegate {
  func tweetBar(tweetBar: TweetBar, didTapReply username: String) {
    let vc = ComposeViewController()
    vc.delegate = self
    vc.usernameForReply = username
    self.navigationController?.pushViewController(vc, animated: false)
  }
}
