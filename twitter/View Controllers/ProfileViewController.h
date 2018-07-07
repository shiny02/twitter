//
//  ProfileViewController.h
//  twitter
//
//  Created by Youngmin Shin on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"
@interface ProfileViewController : UIViewController
@property (strong, nonatomic) Tweet * tweet;
@property (strong, nonatomic) User * user;
@end
