//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Youngmin Shin on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.tweetTextLabel.text = self.tweet.text;
    self.dateLabel.text = self.tweet.createdAtString;
    self.likesLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] stringByAppendingString:@" Likes"];
    
    
    self.profileImageView.image = nil;
    if (self.tweet.user.profileImageUrl != nil) {
        [self.profileImageView setImageWithURL:self.tweet.user.profileImageUrl];
    }
    
    
    
    
}

- (IBAction)tapRetweet:(id)sender {
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
    
  //  [self refreshData];
    
}

- (IBAction)tapLike:(id)sender {
    
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

- (void) refreshData{
    self.likesLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] stringByAppendingString:@" Likes"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
