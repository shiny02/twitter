//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetDetailViewController.h"


@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray* tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    // Get timeline

//    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray<Tweet *> *tweets, NSError *error) {
//        if(tweets){
//            NSLog(@"Success");
//            for (Tweet * tweet in tweets)
//            {
//                NSString *text = tweet.text;
//                NSLog(@"%@", text);
//            }
//            self.tweets = tweets;
//            [self.tableView reloadData];
//
//
//        }
//        else {
//            NSLog(@"Fail!");
//        }
//    }];
    
    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    


}

-(void)fetchTweets
{
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray<Tweet *> *tweets, NSError *error) {
        if(tweets){
            NSLog(@"Success");
            for (Tweet * tweet in tweets)
            {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
            self.tweets = tweets;
            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
            
            
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

- (IBAction)didTapLogout:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout]; 
    
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"TweetDetailViewController"])
    {
    
    TweetCell * tappedCell = sender;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:tappedCell];
    
    Tweet * tweetToDetail = self.tweets[indexPath.row];
    TweetDetailViewController * tweetDetailsViewController = [segue destinationViewController];
    tweetDetailsViewController.tweet = tweetToDetail;
    }
    
    else{
    
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
    }
}



@end
