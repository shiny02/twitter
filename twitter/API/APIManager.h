//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"
#import "User.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSMutableArray<Tweet*> *tweets, NSError *error))completion;

- (void)getUserTweets:(User *)user WithCompletion:(void(^)(NSMutableArray<Tweet*> *tweets, NSError *error))completion;

- (void)postStatusWithText:(NSString *)text completion:(void(^)(Tweet *tweet, NSError *error))completion;

- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)getUserInfoWithCompletion:(void(^)(User *user, NSError *error))completion;


@end
