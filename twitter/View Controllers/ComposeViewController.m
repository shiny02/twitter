//
//  ComposeViewController.m
//  twitter
//
//  Created by Youngmin Shin on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeComposeTweet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendTweet;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;

- (void)textViewDidChange:(UITextView *)textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tweetTextView.layer.borderWidth = 5.0f;
    self.tweetTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
   self.tweetTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onClose:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}



- (IBAction)onPostTweet:(id)sender {
    
    NSUInteger characterCount = [self.tweetTextView.text length];
    if(characterCount > 140)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tweet too long" message:@"The tweet exceeds the 140 character limit." preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Edit tweet" style:UIAlertActionStyleDefault handler:nil];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else{
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
    
}


- (void)textViewDidChange:(UITextView *)textView{
  
    NSUInteger characterCount = [self.tweetTextView.text length];
    
    self.characterCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)characterCount];

    if(characterCount > 140){
        self.characterCount.textColor =  [UIColor colorWithRed:(255.0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    }
    else if(characterCount > 120){
        self.characterCount.textColor =  [UIColor colorWithRed:(255.0/255.0) green:(204.0/255.0) blue:(0/255.0) alpha:1];
    }
    else{
        self.characterCount.textColor =  [UIColor colorWithRed:(0/255.0) green:(204.0/255.0) blue:(0.0/255.0) alpha:1];
    }
    
}

//- (BOOL)textView:(UITextView *)tweetTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    // Set the max character limit
//    int characterLimit = 140;
//
//    // Construct what the new text would be if we allowed the user's latest edit
//    NSString *newText = [self.tweetTextView.text stringByReplacingCharactersInRange:range withString:text];
//
//    // TODO: Update Character Count Label
//
//    // The new text should be allowed? True/False
//    return newText.length < characterLimit;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
