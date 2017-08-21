//
//  MainId.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 12/13/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "MainId.h"



@implementation MainId

+(NSString*)mainId
{
    RLMResults * mainIds = [MainId allObjects];
    MainId * mainId = [mainIds firstObject];
    return mainId.mainId;
}

+(void)setMainId:(NSString*)mainId
{
    [[RLMRealm defaultRealm] beginWriteTransaction];
    RLMResults * mainIds = [MainId allObjects];
    MainId * mainID = [mainIds firstObject];
    mainID.mainId = mainId;
    [[RLMRealm defaultRealm] commitWriteTransaction];
}
@end
