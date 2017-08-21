//
//  IGUser.m
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import "IGUser.h"

@implementation IGUser

@synthesize Id,bio,website,username,full_name,last_name,first_name,media_count,follows_count,profile_picture,followed_by_count;

+ (IGUser *)userWithDictionary:(NSDictionary*)dict
{

    
    
IGUser *user = [[IGUser alloc]init];
    
    user.Id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"pk"]];
    user.bio = [dict objectForKey:@"biography"];
    user.website = [dict objectForKey:@"external_url"];
    user.username = [dict objectForKey:@"username"];
   // user.last_name = [dict objectForKey:@"last_name"];
    user.full_name = [dict objectForKey:@"full_name"];
   // user.first_name = [dict objectForKey:@"first_name"];
    user.profile_picture = [dict objectForKey:@"profile_pic_url"];
    user.media_count = [dict objectForKey:@"media_count"];
    user.follows_count = [dict objectForKey:@"following_count"];
    user.followed_by_count = [dict objectForKey:@"follower_count"];
   
    return user;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.Id forKey:@"id"];
    [encoder encodeObject:self.bio forKey:@"bio"];
    [encoder encodeObject:self.website forKey:@"website"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.last_name forKey:@"last_name"];
    [encoder encodeObject:self.full_name forKey:@"full_name"];
    [encoder encodeObject:self.first_name forKey:@"first_name"];
    [encoder encodeObject:self.profile_picture forKey:@"profile_picture"];
    [encoder encodeObject:self.media_count forKey:@"media_count"];
    [encoder encodeObject:self.follows_count forKey:@"follows_count"];
    [encoder encodeObject:self.followed_by_count forKey:@"followed_by_count"];
     [encoder encodeObject:self.password forKey:@"password"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    if(self)
    {
        self.Id =[decoder decodeObjectForKey:@"id"];
        self.bio = [decoder decodeObjectForKey:@"bio"];
        self.website= [decoder decodeObjectForKey:@"website"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.last_name = [decoder decodeObjectForKey:@"last_name"];
        self.full_name = [decoder decodeObjectForKey:@"full_name"];
        self.first_name = [decoder decodeObjectForKey:@"first_name"];
        self.profile_picture = [decoder decodeObjectForKey:@"profile_picture"];
        self.media_count = [decoder decodeObjectForKey:@"media_count"];
        self.follows_count = [decoder decodeObjectForKey:@"follows_count"];
        self.followed_by_count = [decoder decodeObjectForKey:@"followed_by_count"];
        self.password =  [decoder decodeObjectForKey:@"password"];
    }
    
    return self;
}

@end
