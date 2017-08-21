//
//  IGVideo.m
//  InstagramRepost
//
//  Created by DEVSTEAM.MOBI TEAM on 3/18/16.
//  Copyright (c) 2016 DEVSTEAM.MOBI WORKS. All rights reserved.
//

#import "IGVideo.h"

@implementation IGVideo
+(IGVideo*)videoWithDictionary:(NSDictionary*)dict
{
    
    
    NSArray*dictArray = (NSArray*)dict;
    
 
   
    IGVideo* video = [[IGVideo alloc]init];
    
    NSDictionary* standardDictionary = dictArray[0];
    NSDictionary* lowDictionary = dictArray[0];
    
//    NSDictionary* standardDictionary = [dict objectForKey:@"standard_resolution"];
//    NSDictionary* lowDictionary = [dict objectForKey:@"low_resolution"];
    
    video.low_resolution =[lowDictionary objectForKey:@"url"];
    video.standard_resolution =[standardDictionary objectForKey:@"url"];
    
    return video;
}
@end
