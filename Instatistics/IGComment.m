//
//  IGComment.m
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import "IGComment.h"


@implementation IGComment
@synthesize Id,user,text,createdTime,mediaId;
+(IGComment*)commentWithDictionary:(NSDictionary*)dict
{
    IGComment* comment = [[IGComment alloc]init];
    
    comment.createdTime =[NSString stringWithFormat:@"%@",[dict objectForKey:@"created_at_utc"]] ;
    comment.text = [dict objectForKey:@"text"];
    comment.user = [IGUser userWithDictionary:[dict objectForKey:@"user"]];
    comment.Id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"pk"]];
    comment.mediaId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"media_id"]];
    return comment;
}
@end
