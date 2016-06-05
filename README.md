# Tweeter
Twitter Client for IOS Codepath

Submitted by: Yat Choi

Time spent: 12 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can sign in using OAuth login flow
* [x] User can view last 20 tweets from their home timeline
* [x] The current signed in user will be persisted across restarts
* [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. In other words, design the custom cell with the proper Auto Layout settings. You will also need to augment the model classes.
* [x] User can pull to refresh
* [x] User can compose a new tweet by tapping on a compose button.
* [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
* [x] Dragging anywhere in the view should reveal the menu.
* [x] The menu should include links to your profile, the home timeline, and the mentions view.
* [x] Contains the user header view (implemented as a custom view)
* [x] Contains a section with the users basic stats: # tweets, # following, # followers
* [x] Tapping on a user image should bring up that user's profile page

The following **optional** functionality is complete:

* [ ] When composing, you should have a countdown in the upper right for the tweet limit.
* [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
* [ ] Retweeting and favoriting should increment the retweet and favorite count.
* [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to this guide for help on implementing unretweeting.
* [x] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
* [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
* [ ] Pulling down the profile page should blur and resize the header image.
* [ ] Account switching
* [ ] Long press on tab bar to bring up Account view with animation
* [ ] Tap account to switch to
* [ ] Include a plus button to add an Account
* [ ] Swipe to delete an account

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://imgur.com/ejPxeFF.gif' title='Video
Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Didn't get to spend as much time on this as I'd have liked. Finished all required steps, and a few
optionals.

I lost a lot of time doing AutoLayout programmatically, which was something I didn't account for. It was
much harder to do because I didn't have the visual aid, but it was good for me to learn because I think
we do everything programmatically here at Airbnb.

## License

    Copyright 2016 Yat Choi

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
