//
//  IGComment.h
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGUser.h"

@interface IGComment : RLMObject {
    
}
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * createdTime;
@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) IGUser * user;
@property (nonatomic,retain) NSString* mediaId;

+(IGComment*)commentWithDictionary:(NSDictionary*)dict;

@end
RLM_ARRAY_TYPE(IGComment)
