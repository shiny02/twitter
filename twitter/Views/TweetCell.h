//
//  TweetCell.h
//  twitter
//
//  Created by Youngmin Shin on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userHandle;
//@property (strong, nonatomic) IBOutlet UILabel *tweetBody;
@property (weak, nonatomic) IBOutlet UILabel *numOfReplies;
@property (weak, nonatomic) IBOutlet UILabel *numOfRetweets;
@property (weak, nonatomic) IBOutlet UILabel *numOfLikes;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@property (weak, nonatomic) Tweet * tweet; 
@end
