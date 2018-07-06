//
//  Tweet.m
//  twitter
//
//  Created by Youngmin Shin on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"
#import "NSDate+DateTools.h"

@implementation Tweet

-(instancetype)initWithDictionary:(NSDictionary *) dictionary
{
    self = [super init];
    
    if (self)
    {
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil)
        {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        NSString *originalDateString = dictionary[@"created_at"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        
        NSDate *date = [formatter dateFromString:originalDateString];
        NSString * ago = [date shortTimeAgoSinceNow];
        self.createdAtString = ago;
       // NSLog(@"%@", ago);
        //formatter.dateStyle = NSDateFormatterShortStyle;
//        formatter.timeStyle = NSDateFormatterNoStyle;
        
//        self.createdAtString = [formatter stringFromDate:date];
    }
    
    return self;
}

+(NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries
{
    NSMutableArray * tweets = [[NSMutableArray alloc] init];
    
    for(NSDictionary * dictionary in dictionaries)
    {
        Tweet * currentTweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:currentTweet];
    }
    return tweets;
}

@end
