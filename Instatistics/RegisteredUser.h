//
//  RegisteredUser.h
//  DeepFollowers Tracker
//
//  Created by Devsteam.Mobi iMac on 12/13/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <Realm/Realm.h>
#import "MainUser.h"

@interface RegisteredUser : RLMObject
@property MainUser *firstRegisteredUser;
@property MainUser *currentUser;
@property MainUser *previousUser;
@property NSString *userId;
+(RLMResults*)allUsers;
@end
