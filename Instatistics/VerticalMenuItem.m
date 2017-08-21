//
//  VerticalMenuItem.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 12/1/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "VerticalMenuItem.h"


@implementation VerticalMenuItem
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _title = @"";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    
    if (self) {
        _title = dict[@"title"];
        _currentCount = [dict[@"currentCount"] floatValue];
        _previousCount = [dict[@"previousCount"] floatValue];
        _difference = _currentCount - _previousCount;
        _arrowImage = [UIImage imageNamed:_difference >= 0 ? @"upArrowGreenImage" : @"downArrowRedImage"];
        _iconImage = [UIImage imageNamed:dict[@"icon"]];
    }
    return self;
}

@end
