//
//  TweetCell.m
//  twitter
//
//  Created by Youngmin Shin on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(UIButton *)sender {
    if(!self.tweet.favorited)
    {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        UIImage *btnImage = [UIImage imageNamed:@"favor-icon-red.png"];
        [sender setImage:btnImage forState:UIControlStateNormal];
    }
    else{
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        UIImage *btnImage = [UIImage imageNamed:@"favor-icon.png"];
        [sender setImage:btnImage forState:UIControlStateNormal];
        
    }
    
    [self refreshData];
}

- (IBAction)didTapRT:(UIButton *)sender {
    
    if(!self.tweet.retweeted)
    {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        UIImage *btnImage = [UIImage imageNamed:@"retweet-icon-green.png"];
        [sender setImage:btnImage forState:UIControlStateNormal];
    }
    else{
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
        UIImage *btnImage = [UIImage imageNamed:@"retweet-icon.png"];
        [sender setImage:btnImage forState:UIControlStateNormal];
        
    }
    
    [self refreshData];
    
}


- (void) refreshData{
    self.numOfLikes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    self.numOfRetweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
}

- (void)setTweet:(Tweet*)tweet
{
    _tweet = tweet;
    
    self.userName.text = self.tweet.user.name;
    self.userHandle.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.tweetText.text = self.tweet.text;
    self.tweetDate.text = self.tweet.createdAtString;
    
    UIImage *likeImage = [UIImage imageNamed:@"favor-icon.png"];
    [self.likeButton setImage:likeImage forState:UIControlStateNormal];
    
    
    UIImage *RTImage = [UIImage imageNamed:@"retweet-icon.png"];
    [self.retweetButton setImage:RTImage forState:UIControlStateNormal];
    
    
    if (self.tweet.favorited) {
        UIImage *likeImage = [UIImage imageNamed:@"favor-icon-red.png"];
        [self.likeButton setImage:likeImage forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted){
        UIImage *RTImage = [UIImage imageNamed:@"retweet-icon-green.png"];
        [self.retweetButton setImage:RTImage forState:UIControlStateNormal];
    }
    
    self.numOfLikes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    self.numOfRetweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    //self.numOfReplies =
    [self.userName sizeToFit];
    [self.tweetText sizeToFit];
    
    
    self.profileImage.image = nil;
    if (self.tweet.user.profileImageUrl != nil) {
        [self.profileImage setImageWithURL:self.tweet.user.profileImageUrl];
    }
}

@end
