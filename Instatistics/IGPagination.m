//
//  IGPagination.m
//  Instamap
//
//  Created by Devsteam.mobi on 11/17/11.
//  Copyright (c) 2011 NextRoot. All rights reserved.
//

#import "IGPagination.h"
#import "AppUtils.h"

@implementation IGPagination
@synthesize nextUrl,nextMaxId,nextMinId;

+(IGPagination*)paginationWithDictionary:(NSDictionary*)dict
{
    IGPagination* pagination = [[IGPagination alloc]init];
    
    pagination.nextMaxId = [AppUtils isValidObject:[dict objectForKey:@"next_max_id"]] ? [NSString stringWithFormat:@"%@",[dict objectForKey:@"next_max_id"]] : @"";
    
    if(pagination.nextMaxId==nil)
        pagination.nextMaxId=  [dict objectForKey:@"next_max_tag_id"];
    
    if(pagination.nextMaxId==nil)
        pagination.nextMaxId=  [dict objectForKey:@"next_max_like_id"];
    
    if(pagination.nextMaxId==nil)
        pagination.nextMaxId=  [dict objectForKey:@"next_cursor"];
    
    
    pagination.nextMinId = [dict objectForKey:@"next_min_id"];
    
    if(pagination.nextMinId==nil)
        pagination.nextMinId=  [dict objectForKey:@"next_min_tag_id"];
    
    if(pagination.nextMinId==nil)
        pagination.nextMinId=  [dict objectForKey:@"next_min_like_id"];
    
    
    pagination.nextUrl = [dict objectForKey:@"next_url"];
    
    return pagination;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"next_max_id=%@ next_min_id=%@ next_Url=%@",self.nextMaxId,nextMinId,nextUrl];
}

@end
