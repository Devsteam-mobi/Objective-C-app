//
//  IGImage.m
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import "IGImage.h"

@implementation IGImage
+(IGImage*)imageWithDictionary:(NSDictionary*)dict
{
    
    
    NSArray*dictArray = (NSArray*)dict;
    
    IGImage* image = [[IGImage alloc]init];
    
    NSDictionary* thumbnailDictionary = [dictArray lastObject];
    NSDictionary* standardDictionary = dictArray[dictArray.count-3];
    NSDictionary* lowDictionary = dictArray[dictArray.count-2];
    
    
//    NSDictionary* thumbnailDictionary = [dict objectForKey:@"thumbnail"];
//    NSDictionary* standardDictionary = [dict objectForKey:@"standard_resolution"];
//    NSDictionary* lowDictionary = [dict objectForKey:@"low_resolution"];
//    
    image.low_resolution =[lowDictionary objectForKey:@"url"];
    image.standard_resolution =[standardDictionary objectForKey:@"url"];
    image.thumbnail =[thumbnailDictionary objectForKey:@"url"];
    
    return image;
}
@end
