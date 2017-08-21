//
//  MainUser.m
//  DeepFollowers Tracker
//
//  Created by Devsteam.Mobi iMac on 12/13/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "MainUser.h"
#import "RegisteredUser.h"
#import "MainId.h"

@implementation MainUser


+(void)addItemsFromArray:(RLMArray*)newArrray containedIn:(RLMArray*)oldArray toArray:(RLMArray*)result
{
    
    [MainUser removeAllObjectsFromArray:result];
    
    for (IGUser *user in newArrray) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",user.Id];
        
        if ([oldArray objectsWithPredicate:predicate].count != 0) {
            [MainUser addItem:user toArray:result];
        }
        
    }
    
}

+(void)addItemsFromArray:(RLMArray*)newArrray notContainedIn:(RLMArray*)oldArray toArray:(RLMArray*)result
{
    
    [MainUser removeAllObjectsFromArray:result];
    
    for (IGUser *user in newArrray) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",user.Id];
        if ([oldArray objectsWithPredicate:predicate].count == 0) {
            [MainUser addItem:user toArray:result];
        }
        
    }
    
}

+(void)addCommentsFromArray:(RLMArray*)newArrray notContainedIn:(RLMArray*)oldArray toArray:(RLMArray*)result
{
    
    [MainUser removeAllObjectsFromArray:result];
    for (IGComment *comment in newArrray) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",comment.Id];
        if ([oldArray objectsWithPredicate:predicate].count == 0) {
            [MainUser addItem:comment toArray:result];
        }
        
    }
    
}

+(void)addLikersFromArray:(RLMArray*)newArrray notContainedIn:(RLMArray*)oldArray toArray:(RLMArray*)result;
{
    
    [MainUser removeAllObjectsFromArray:result];
    
    for (IGLiker *liker in newArrray) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.Id == %@ AND self.mediaId == %@",liker.user.Id, liker.mediaId];
        if ([oldArray objectsWithPredicate:predicate].count == 0) {
            [MainUser addItem:liker toArray:result];
        }
        
    }
    
}

+(void)removeAllObjects
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}


+(void)addItem:(RLMObject*)item toArray:(RLMArray*)array
{

    [[array realm] beginWriteTransaction];
    [array addObject:item];
    [[array realm] commitWriteTransaction];

}

+(void)addItems:(NSArray*)items toArray:(RLMArray*)array
{
    [[array realm] beginWriteTransaction];
    [array addObjects:items];
    [[array realm] commitWriteTransaction];
}


+(MainUser*)mainUser
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.userId == %@",[MainId mainId]];
    RLMResults * allRegisteredUsers = [RegisteredUser allObjects];
    RLMResults * result = [allRegisteredUsers objectsWithPredicate:predicate];
    RegisteredUser * registeredUser = [result firstObject];
    MainUser *mainUser = registeredUser.currentUser; // retrieves all Dogs from the default Realm
    return mainUser;
}

+(MainUser*)firstRegisteredUser
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.userId == %@",[MainId mainId]];
    RLMResults * allRegisteredUsers = [RegisteredUser allObjects];
    RLMResults * result = [allRegisteredUsers objectsWithPredicate:predicate];
    RegisteredUser * registeredUser = [result firstObject];
    MainUser *mainUser = registeredUser.firstRegisteredUser; // retrieves all Dogs from the default Realm
    return mainUser;
}

+(MainUser*)previousUser
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.userId == %@",[MainId mainId]];
    RLMResults * allRegisteredUsers = [RegisteredUser allObjects];
    RLMResults * result = [allRegisteredUsers objectsWithPredicate:predicate];
    RegisteredUser * registeredUser = [result firstObject];
    MainUser *previousUser = registeredUser.previousUser; // retrieves all Dogs from the default Realm
    return previousUser;
}


+(void)setMainUser:(MainUser*)user
{
    if (user == nil) {
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.userId == %@",user.user.Id];
    RLMResults * allRegisteredUsers = [RegisteredUser allObjects];
    RLMResults * result = [allRegisteredUsers objectsWithPredicate:predicate];
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    
    long dateTimeInterval = (long)[[NSDate date] timeIntervalSince1970];
    user.createdTime = [NSString stringWithFormat:@"%ld",dateTimeInterval];
    
    if (result.count) {
        RegisteredUser * registeredUser = [result firstObject];
        if ([registeredUser.previousUser.createdTime longLongValue] + 24 * 60 + 60 <= dateTimeInterval)
        {
            registeredUser.previousUser = registeredUser.currentUser ;
        }
        
        else if(registeredUser.previousUser.isComplete == NO)
        {
            registeredUser.previousUser = user;
            registeredUser.firstRegisteredUser = user;
        }
            
        registeredUser.currentUser = user;
    }
    
    else
    {
        RegisteredUser * registeredUser = [RegisteredUser new];
        registeredUser.userId = user.user.Id;
        registeredUser.previousUser = user;
        registeredUser.currentUser = user;
        [[RLMRealm defaultRealm] addObject:registeredUser];
    }
    
    RLMResults * mainIds = [MainId allObjects];
    if (mainIds.count == 0) {
        MainId * mainId = [MainId new];
        mainId.mainId = user.user.Id;
        [[RLMRealm defaultRealm] addObject:mainId];
    }
    
    else
    {
        MainId * mainId = [mainIds firstObject];
        mainId.mainId = user.user.Id;
    }
    
    [[RLMRealm defaultRealm] commitWriteTransaction];
}


+(void)removeUser:(MainUser*)user
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.userId == %@",user.user.Id];
    RLMResults * allRegisteredUsers = [RegisteredUser allObjects];
    RLMResults * result = [allRegisteredUsers objectsWithPredicate:predicate];
    [[RLMRealm defaultRealm] beginWriteTransaction];
    RegisteredUser *registeredUser = [result firstObject];
    [[registeredUser realm] deleteObject:registeredUser];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}


+(void)setUser:(IGUser*)user
{
    MainUser *mainUser = [MainUser mainUser];
    [[mainUser realm] beginWriteTransaction];
    mainUser.user = user;
    [[mainUser realm] commitWriteTransaction];
}


+(void)removeAllObjectsFromArray:(RLMArray*)array
{
    [[array realm] beginWriteTransaction];
    [array removeAllObjects];
    [[array realm] commitWriteTransaction];
}





@end
