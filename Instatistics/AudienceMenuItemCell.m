//
//  AudienceMenuItemCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "AudienceMenuItemCell.h"
#import "AppUtils.h"
#import "UserStatisticsViewController.h"
@implementation AudienceMenuItemCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"AudienceMenuItemCell";
        self.staticHeightForCell = 40.0f;
        self.backgroundColor = [AppUtils lightBlackColor];
    }
    return self;
}

@end


@implementation AudienceMenuItemCell

- (void)setUpWithSource:(AudienceMenuItemCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _userImage.image = [UIImage imageNamed:source.itemInfo[@"image"]];
    _nameLabel.text = source.itemInfo[@"title"];
    _userImage.alpha = [AppUtils showLockedItems];
    _selectButton.tag = source.cellTag;
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
}

@end




