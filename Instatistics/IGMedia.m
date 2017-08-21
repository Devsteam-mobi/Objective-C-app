//
//  IGMedia.m
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import "IGMedia.h"

@implementation IGMedia
@synthesize Id,link,tags,type,user,image,video,likes,filter,caption,section,comments,location,likes_count,created_time,userHasLiked,comment_count,received_time;

+(IGMedia*)mediaWithDictionary:(NSDictionary*)dict
{
    
    IGMedia* media = [[IGMedia alloc]init];
    
    
    
    
    media.Id = [dict objectForKey:@"id"];
    
   // NSLog(@"Media Type %@", [dict objectForKey:@"media_type"]);
    
    if([[dict objectForKey:@"media_type"] intValue] == 2)
    {
        media.type = @"video";
    }
    else {
        media.type = @"photo";
    }
   // media.type = [dict objectForKey:@"media_type"];
    
    
    media.filter = [NSString stringWithFormat:@"%@",[dict objectForKey:@"filter_type"]];
    media.link = [dict objectForKey:@"code"];
    
    
    
    
    media.created_time =  @([[dict objectForKey:@"device_timestamp"] longValue]);
    
    if ([[dict objectForKey:@"device_timestamp"] longValue] > pow(10, 10) ) {
    media.created_time =  @([[dict objectForKey:@"device_timestamp"] longValue]/1000);
    }
    
    media.has_more_comments =  @([[dict objectForKey:@"has_more_comments"] intValue]);
    media.received_time = [NSNumber numberWithLong:(long)[[NSDate date] timeIntervalSince1970]];
    
    media.image = [IGImage imageWithDictionary:[dict objectForKey:@"image_versions2"][@"candidates"]];
    media.user = [IGUser userWithDictionary:[dict objectForKey:@"user"]];
    media.video = [IGVideo videoWithDictionary:[dict objectForKey:@"video_versions"]];
    
//    NSMutableArray* tagArray = [[NSMutableArray alloc]init];
//    for(NSString* tagString in [dict objectForKey:@"tags"])
//    {
//        [tagArray addObject:[IGTag tagWithString:tagString]];
//    }
//    media.tags = tagArray;
    
    
    media.likes_count = [dict objectForKey:@"like_count"];
    
    media.comment_count = [dict objectForKey:@"comment_count"];
    
        for (NSDictionary* likeDict in [dict objectForKey:@"likers"]) {
            IGLiker* liker = [IGLiker likerWithDictionary:likeDict];
            liker.mediaId = media.Id;
            [media.likes addObject:liker];
        }
    
    
    for (NSDictionary* comment in [dict objectForKey:@"comments"]) {
        [media.comments addObject:[IGComment commentWithDictionary:comment]];
    }
    
    if([dict objectForKey:@"location"]!=[NSNull null])
        media.location = [IGLocation locationWithDictionary:[dict objectForKey:@"location"]];
    
    if([dict objectForKey:@"caption"]!=[NSNull null])
        media.caption= [IGComment commentWithDictionary:[dict objectForKey:@"caption"]];
    
    if([dict objectForKey:@"has_liked"]!=nil)
        media.userHasLiked = [dict objectForKey:@"has_liked"];
    
    
    return media;
}





@end
