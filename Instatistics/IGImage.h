//
//  IGImage.h
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGImage.h"
#import <Realm/Realm.h>

@interface IGImage : RLMObject {
    
}
@property (nonatomic, retain) NSString * low_resolution;
@property (nonatomic, retain) NSString * standard_resolution;
@property (nonatomic, retain) NSString * thumbnail;
+(IGImage*)imageWithDictionary:(NSDictionary*)dict;

@end
RLM_ARRAY_TYPE(IGImage)
