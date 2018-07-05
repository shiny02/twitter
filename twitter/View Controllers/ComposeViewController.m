//
//  ComposeViewController.m
//  twitter
//
//  Created by Youngmin Shin on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeComposeTweet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendTweet;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClose:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onPostTweet:(id)sender {
    
    NSString * tweetText = self.tweetTextView.text;
[[APIManager shared] postStatusWithText:(NSString *)tweetText completion:^(Tweet *tweet, NSError *error)
  {
     if(tweet)
     {
         [self.delegate didTweet:tweet];
         NSLog(@"Success, %@ :on system", tweet.text);
         [self dismissViewControllerAnimated:YES completion:nil];
     }
     else{
         NSLog(@"Failed, lmao");
         
     }
 
 
 }];
    
    



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
