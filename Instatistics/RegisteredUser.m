//
//  RegisteredUser.m
//  DeepFollowers Tracker
//
//  Created by Devsteam.Mobi iMac on 12/13/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "RegisteredUser.h"



@implementation RegisteredUser

+(RLMResults*)allUsers
{

    return [RegisteredUser allObjects];

}

@end
