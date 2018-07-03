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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray* tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    // Get timeline
//    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
//        if (tweets) {
//            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (NSDictionary *dictionary in tweets) {
//                NSString *text = dictionary[@"text"];
//                NSLog(@"%@", text);
//            }
//            self.tweets = [Tweet tweetsWithArray:tweets];
//            [self.tableView reloadData];
//
//        } else {
//            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
//        }
//    }];
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray<Tweet *> *tweets, NSError *error) {
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
    
    //cell.blurbLabel.text = movie[@"overview"];
    
    //NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    //NSString *posterURLString = movie[@"poster_path"];
    
    //NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    //NSURL * posterURL = [NSURL URLWithString:fullPosterURLString];
    //cell.posterView.image = nil;
    //[cell.posterView setImageWithURL:cell.movie.posterUrl];
    
    return cell;
    
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
