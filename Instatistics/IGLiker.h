//
//  IGLiker.h
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "IGLiker.h"
#import "IGUser.h"


@interface IGLiker : RLMObject<NSCoding> {
    
}
@property (nonatomic, retain) IGUser * user;
@property (nonatomic, retain) NSString * mediaId;
+(IGLiker*)likerWithDictionary:(NSDictionary*)dict;
@end

RLM_ARRAY_TYPE(IGLiker)
