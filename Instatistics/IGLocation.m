//
//  IGLocation.m
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import "IGLocation.h"


@implementation IGLocation
@synthesize Id,name,latitude,longitude;
+(IGLocation*)locationWithDictionary:(NSDictionary*)dict
{
    IGLocation* location = [[IGLocation alloc]init];    
    
    location.Id = [NSString stringWithFormat:@"%@", [dict objectForKey:@"pk"]];
    
    location.name = [dict objectForKey:@"name"];
    location.longitude = [dict objectForKey:@"lng"];
    location.latitude = [dict objectForKey:@"lat"];
    return location;
    
   
}
@end
