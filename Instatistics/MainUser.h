//
//  MainUser.h
//  DeepFollowers Tracker
//
//  Created by Devsteam.Mobi iMac on 12/13/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <Realm/Realm.h>
#import "IGUser.h"
#import "IGMedia.h"

@interface MainUser : RLMObject

@property IGUser *user;
@property RLMArray<IGUser> *userFollowers;
@property RLMArray<IGUser> *userNewFollowers;
@property RLMArray<IGUser> *userLostFollowers;

@property RLMArray<IGUser> *userFollowings;
@property RLMArray<IGUser> *userNewFollowings;

@property RLMArray<IGUser> *userMutualFollowers;


@property RLMArray<IGUser> *usersNotFollowMeBack;

@property RLMArray<IGUser> *userIAmNotFollowingBack;

@property RLMArray<IGComment> *comments;
@property RLMArray<IGLiker> *likes;

@property RLMArray<IGComment> *deletedComments;
@property RLMArray<IGLiker> *deletedLikes;


@property RLMArray<IGMedia> *photos;
@property RLMArray<IGMedia> *videos;
@property BOOL isComplete;

@property (nonatomic, retain) NSString * createdTime;

+(MainUser*)mainUser;
+(MainUser*)firstRegisteredUser;
+(MainUser*)previousUser;
+(void)setUser:(IGUser*)user;
+(void)setMainUser:(MainUser*)user;
+(void)removeUser:(MainUser*)user;
+(void)addItem:(RLMObject*)item toArray:(RLMArray*)array;
+(void)addItems:(NSArray*)items toArray:(RLMArray*)array;
+(void)removeAllObjects;

+(void)removeAllObjectsFromArray:(RLMArray*)array;


+(void)addItemsFromArray:(RLMArray*)newArrray containedIn:(RLMArray*)oldArray toArray:(RLMArray*)result;
+(void)addItemsFromArray:(RLMArray*)newArrray notContainedIn:(RLMArray*)oldArray toArray:(RLMArray*)result;
+(void)addCommentsFromArray:(RLMArray*)newArrray notContainedIn:(RLMArray*)oldArray toArray:(RLMArray*)result;
+(void)addLikersFromArray:(RLMArray*)newArrray notContainedIn:(RLMArray*)oldArray toArray:(RLMArray*)result;

@end
