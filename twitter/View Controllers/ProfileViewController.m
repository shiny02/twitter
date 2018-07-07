//
//  ProfileViewController.m
//  twitter
//
//  Created by Youngmin Shin on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "Tweet.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "TweetDetailViewController.h"

@interface ProfileViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * tweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//
    NSLog(@"helo");
    if(!self.user)
    {
        NSLog(@"helllo");
        [[APIManager shared] getUserInfoWithCompletion:^(User *user, NSError *error) {
            
                if (user) {
                    self.user = user;
                } else {
                    NSLog(@"Error getting home timeline: %@", error.localizedDescription);
                }
            }];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = [@"@" stringByAppendingString:self.user.screenName];
    self.summaryLabel.text = self.user.userSummary;
    self.tweetsLabel.text = [@"Tweets " stringByAppendingString:[NSString stringWithFormat:@"%@", self.user.numOfTweets]];
    self.followersLabel.text = [@"Followers " stringByAppendingString:[NSString stringWithFormat:@"%@", self.user.followers]];
    self.followingLabel.text = [@"Following " stringByAppendingString:[NSString stringWithFormat:@"%@", self.user.following]];
    
    
    self.profileImage.image = nil;
    if (self.tweet.user.profileImageUrl != nil) {
        [self.profileImage setImageWithURL:self.tweet.user.profileImageUrl];
    }
    
    self.backdropImage.image = nil;
    if (self.tweet.user.profileBannerUrl != nil) {
        [self.backdropImage setImageWithURL:self.tweet.user.profileBannerUrl];
    }
    
    
    [[APIManager shared] getUserTweets:self.user WithCompletion:^(NSMutableArray<Tweet *> *tweets, NSError *error) {
        if(tweets){
            NSLog(@"Success");
            for (Tweet * tweet in tweets)
            {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
            self.tweets = tweets;
            [self.tableView reloadData];
            
            
        }
        else {
            NSLog(@"Fail!");
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    //Movie * movie = self.movies[indexPath.row];
    
    cell.tweet = self.tweets[indexPath.row];
    
    
    return cell;
    
}

- (void)didTweet:(Tweet *)tweet{
    
    [self.tweets insertObject:tweet atIndex:0];
    
    [self.tableView reloadData];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"ComposeVC"])
    {

        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
        composeController.tweetTextView.text = self.handleLabel.text;
        composeController.previousUserHandle = self.handleLabel.text;
    }
    else if([[segue identifier] isEqualToString:@"ProfileViewCSegue"])
    {
        TweetCell * tappedCell = sender;
        NSIndexPath * indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet * tweetToDetail = self.tweets[indexPath.row];
        
        
        UINavigationController *navigationController = [segue destinationViewController];
        ProfileViewController *profileViewController = (ProfileViewController*)navigationController.topViewController;
        
        
        profileViewController.tweet = tweetToDetail;
        profileViewController.user = tweetToDetail.user;
    }
    else if([[segue identifier] isEqualToString:@"TweetDetailViewController"])
    {
        
        TweetCell * tappedCell = sender;
        NSIndexPath * indexPath = [self.tableView indexPathForCell:tappedCell];
        
        Tweet * tweetToDetail = self.tweets[indexPath.row];
        
        TweetDetailViewController * tweetDetailsViewController = [segue destinationViewController];
        tweetDetailsViewController.tweet = tweetToDetail;
    }

}


@end
