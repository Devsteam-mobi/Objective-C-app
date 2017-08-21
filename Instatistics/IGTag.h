//
//  IGTag.h
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface IGTag : RLMObject {
    
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber<RLMInt> * mediaCount;
+(IGTag*)tagWithDictionary:(NSDictionary*)dict;
+(IGTag*)tagWithString:(NSString*)tag;

@end
RLM_ARRAY_TYPE(IGTag)
