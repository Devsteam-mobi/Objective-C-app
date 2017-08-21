//
//  IGLogin.m
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import "IGLogin.h"

@implementation IGLogin


- (instancetype)init
{
    self = [super init];
    if (self) {
        _full_name = @"";
        _Id = @"";
        _profile_pic_url = @"";
        _profile_pic_id = @"";
        _username = @"";
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        _full_name = dict[@"full_name"];
        _Id = [dict[@"pk"] stringValue];
        _profile_pic_url = dict[@"profile_pic_url"];
        _profile_pic_id = dict[@"profile_pic_id"];
        _username = dict[@"username"];
    }
    return self;
}

@end
