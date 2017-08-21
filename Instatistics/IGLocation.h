//
//  IGLocation.h
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface IGLocation : RLMObject {
    
}
@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) NSNumber<RLMInt> * latitude;
@property (nonatomic, retain) NSNumber<RLMInt> * longitude;
@property (nonatomic, retain) NSString * name;
+(IGLocation*)locationWithDictionary:(NSDictionary*)dict;
@end
RLM_ARRAY_TYPE(IGLocation)
