//
//  HeaderItemCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "HeaderItemCell.h"
#import "AppUtils.h"
#import "UserStatisticsViewController.h"
@implementation HeaderItemCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"HeaderItemCell";
      self.staticHeightForCell = 28.0f;
  }
  return self;
}

@end


@implementation HeaderItemCell

- (void)setUpWithSource:(HeaderItemCellSource*)source
{
    _userImage.image = [UIImage imageNamed:source.itemInfo[@"image"]];
    _nameLabel.text = source.itemInfo[@"title"];
}

@end




