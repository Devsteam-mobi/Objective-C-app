//
//  IGLiker.m
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import "IGLiker.h"

@implementation IGLiker

@synthesize user;

+ (IGLiker *)likerWithDictionary:(NSDictionary*)dict
{
    IGLiker * liker = [IGLiker new];
    liker.user = [IGUser userWithDictionary:dict];
    return liker;
}


@end
