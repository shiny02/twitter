//
//  Tweet.h
//  twitter
//
//  Created by Youngmin Shin on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Tweet.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *idStr; // For favoriting, retweeting & replying
@property (strong, nonatomic) NSString *text; // Text content of tweet
@property (nonatomic) int favoriteCount; // Update favorite count label
@property (nonatomic) BOOL favorited; // Configure favorite button
@property (nonatomic) int retweetCount; // Update favorite count label
@property (nonatomic) BOOL retweeted; // Configure retweet button
@property (strong, nonatomic) User *user; // Contains name, screenname, etc. of tweet author
@property (strong, nonatomic) NSString *createdAtString; // Display date
@property (strong, nonatomic) NSString *timeSinceString;
// For Retweets
@property (strong, nonatomic) User *retweetedByUser;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

+(NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;
@end
