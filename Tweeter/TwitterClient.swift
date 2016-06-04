//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Yat Choi on 5/31/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
  static let TwitterBaseUrl = "https://api.twitter.com"
  static let TwitterConsumerKey = "wvGpUZhxWngf2r199sjN4BTWC"
  static let TwitterConsumerSecret = "9zs83FKfiUajqC2MAexovpGyyJpXGlBjA8wnWjchM9gpILncKt"
  static let TwitterSignatureMethod = "HMAC-SHA1"
  static let sharedInstance = TwitterClient(baseURL: NSURL(string: TwitterClient.TwitterBaseUrl), consumerKey: TwitterClient.TwitterConsumerKey, consumerSecret: TwitterClient.TwitterConsumerSecret)
  
  var loginSuccess: (() -> ())?
  var loginFailure: ((NSError) -> ())?
  
  var currentAccessToken: String?
  
  func login(success: () -> (), failure: (NSError) -> ()) {
    loginSuccess = success
    loginFailure = failure
    fetchRequestToken()
  }
  
  func logout() {
    User.currentUser = nil
    deauthorize()
    
    NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogout", object: nil)
  }
  
  func handleOpenUrl(url: NSURL) {
    let requestToken = BDBOAuth1Credential(queryString: url.query)
    
    fetchAccessToken(requestToken)
  }
  
  func fetchRequestToken() {
    deauthorize()
    fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweeter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) in
      let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
      UIApplication.sharedApplication().openURL(url)
    }) { (error: NSError!) in
      print("error: \(error.localizedDescription)")
      self.loginFailure?(error)
    }
  }
  
  func fetchAccessToken(requestToken: BDBOAuth1Credential) {
    fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
      print("Got access token")
      self.currentAccessToken = accessToken.token
      self.currentAccount({ (user: User) in
        User.currentUser = user
        self.loginSuccess?()
      }, failure: { (error: NSError) in
        self.loginFailure?(error)
      })
    }) { (error: NSError!) in
      print("Got an error")
      self.loginFailure?(error)
    }
  }
  
  func fetchHomeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
    let endpointString = TwitterClient.TwitterBaseUrl + "/1.1/statuses/home_timeline.json"
    GET(endpointString, parameters: nil, success: { (task: NSURLSessionDataTask, data) in
      let dictionaries = data as! [NSDictionary]
      var tweets = [Tweet]()
      for dictionary in dictionaries {
        tweets.append(Tweet(dictionary: dictionary))
      }
      success(tweets)
    }) { (task: NSURLSessionDataTask?, error: NSError) in
      failure(error)
    }
  }
  
  func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
    let endpointString = TwitterClient.TwitterBaseUrl + "/1.1/account/verify_credentials.json"
    GET(endpointString, parameters: nil, success: { (task: NSURLSessionDataTask, data: AnyObject?) in
      let userDictionary = data as! NSDictionary
      let user = User(dictionary: userDictionary)
      
      success(user)
    }) { (task: NSURLSessionDataTask?, error: NSError) in
      failure(error)
    }
  }
  
  func postTweet(status: String, inReplyTo: String?, success: (Tweet) -> (), failure: (NSError) -> ()) {
    let endpointString = TwitterClient.TwitterBaseUrl + "/1.1/statuses/update.json"
    var params = [String:String]()
    params["status"] = status
    if let inReplyTo = inReplyTo {
      params["in_reply_to_status_id"] = inReplyTo
    }
    
    self.requestSerializer.setAuthorizationHeaderFieldWithToken(buildAuthorizationHeaderToken())
    POST(endpointString, parameters: params, success: { (task: NSURLSessionDataTask, data) in
      let tweet = Tweet(dictionary: data as! NSDictionary)
      print("Successfully tweeted")
      success(tweet)
    }) { (task: NSURLSessionDataTask?, error: NSError) in
      print("Got an error trying to tweet")
      failure(error)
    }
  }
  
  func retweet(id: NSNumber, success: (Tweet) -> (), failure: (NSError) -> ()) {
    let endpointString = "/1.1/statuses/retweet/\(id).json"
    var params = [String: NSNumber]()
    params["id"] = id
    POST(endpointString, parameters: params, success: { (task: NSURLSessionDataTask, data) in
      let retweetedData = data["retweeted_status"]
      let tweet = Tweet(dictionary: retweetedData as! NSDictionary)
      success(tweet)
    }) { (task: NSURLSessionDataTask?, error: NSError) in
      failure(error)
    }
  }
  
  func favourite(id: NSNumber, success: (Tweet) -> (), failure: (NSError) -> ()) {
    let endpointString = "/1.1/favorites/create.json"
    var params = [String: NSNumber]()
    params["id"] = id
    POST(endpointString, parameters: params, success: { (task: NSURLSessionDataTask, data) in
      let favouritedData = data
      let tweet = Tweet(dictionary: favouritedData as! NSDictionary)
      success(tweet)
    }) { (task: NSURLSessionDataTask?, error: NSError) in
      failure(error)
    }
  }
  
  func userByScreenname(screenname: String, success: (User) -> (), failure: (NSError) -> ()) {
    let endpointString = "/1.1/users/show.json"
    var params = [String: String]()
    params["screen_name"] = screenname
    GET(endpointString, parameters: params, success: { (task: NSURLSessionDataTask, data) in
      let user = User(dictionary: data as! NSDictionary)
      success(user)
    }) { (task: NSURLSessionDataTask?, error: NSError) in
      failure(error)
    }
  }
  
  private func buildAuthorizationHeaderToken() -> String {
    var dst = "Oauth oauth_consumer_key=\"\(TwitterClient.TwitterConsumerKey.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()))\""
    
    let s = NSMutableData(length: 32)
    SecRandomCopyBytes(kSecRandomDefault, s!.length, UnsafeMutablePointer<UInt8>(s!.mutableBytes))
    let nonce = s!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    
    dst = dst + ", oauth_nonce=\"\(nonce.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()))\""
    
    dst = dst + ", oauth_signature_method=\"\(TwitterClient.TwitterSignatureMethod)\""
    
    dst = dst + ", oauth_timestamp=\"\(Int64(NSDate().timeIntervalSince1970 * 1000.0))\""
    
    dst = dst + ", oauth_token=\"\(self.currentAccessToken?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()))\""
    
    return ""
  }
  
}
