//
//  IGMedia.h
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGComment.h"
#import "IGImage.h"
#import "IGLocation.h"
#import "IGUser.h"
#import "IGTag.h"
#import "IGVideo.h"
#import "IGLiker.h"


@interface IGMedia : RLMObject {
    
}
@property (nonatomic, retain) NSNumber<RLMInt> * comment_count;
@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) NSNumber<RLMInt> * created_time;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSNumber<RLMInt> * userHasLiked;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * filter;
@property (nonatomic, retain) NSNumber<RLMInt> * likes_count;
@property (nonatomic, retain) NSNumber<RLMInt> * received_time;
@property (nonatomic, retain) NSNumber<RLMInt> * section;
@property (nonatomic, retain) RLMArray<IGComment> * comments;
@property (nonatomic, retain) IGComment * caption;
@property (nonatomic, retain) RLMArray<IGTag>* tags;
@property (nonatomic, retain) RLMArray<IGLiker>* likes;
@property (nonatomic, retain) IGImage * image;
@property (nonatomic, retain) IGVideo * video;
@property (nonatomic, retain) IGLocation * location;
@property (nonatomic, retain) IGUser * user;
@property (nonatomic, retain) NSNumber<RLMInt> * has_more_comments;
+(IGMedia*)mediaWithDictionary:(NSDictionary*)dict;
@end

RLM_ARRAY_TYPE(IGMedia)
