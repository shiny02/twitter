//
//  User.m
//  twitter
//
//  Created by Youngmin Shin on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self)
    {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.followers = dictionary[@"followers_count"];
        
        self.profileBannerUrl = [NSURL URLWithString:dictionary[@"profile_banner_url"]];

        self.profileImageUrl = [NSURL URLWithString:dictionary[@"profile_image_url"]];
        
        
        
        
    }
    return self; 
}

@end
