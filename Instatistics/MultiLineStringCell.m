//
//  MultiLineStringCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "MultiLineStringCell.h"
#import "AppUtils.h"
#import "AppConstants.h"

@implementation MultiLineStringCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"MultiLineStringCell";
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:_lato_font_light size:18];
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor whiteColor];
    }
  return self;
}

@end


@implementation MultiLineStringCell


- (void)setUpWithSource:(MultiLineStringCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    
    if (source.textColor != nil) {
        _infoLabel.textColor = source.textColor;
    }
    _infoLabel.text = source.infoText;
    _infoLabel.font = source.font;
    _infoLabel.textAlignment = source.textAlignment;
}

@end




