//
//  IGVideo.h
//  InstagramRepost
//
//  Created by DEVSTEAM.MOBI TEAM on 3/18/16.
//  Copyright (c) 2016 DEVSTEAM.MOBI WORKS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface IGVideo : RLMObject{
    
}
@property (nonatomic, retain) NSString * low_resolution;
@property (nonatomic, retain) NSString * standard_resolution;
+(IGVideo*)videoWithDictionary:(NSDictionary*)dict;

@end
RLM_ARRAY_TYPE(IGVideo)
