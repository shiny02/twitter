//
//  TweetCell.m
//  twitter
//
//  Created by Youngmin Shin on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet*)tweet
{
    _tweet = tweet;
    
    self.userName.text = self.tweet.user.name;
    self.userHandle.text =   self.tweet.user.screenName;
    self.tweetText.text = self.tweet.text;
    self.tweetDate.text = self.tweet.createdAtString;
    
//    self.profileImage.image = nil;
//    if (self.tweet.pictureURL != nil) {
//        [self.posterView setImageWithURL:self.movie.posterUrl];
}

@end
