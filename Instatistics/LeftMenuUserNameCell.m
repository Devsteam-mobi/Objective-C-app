//
//  LeftMenuUserNameCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "LeftMenuUserNameCell.h"
#import "AppUtils.h"
#import "UserStatisticsViewController.h"
@implementation LeftMenuUserNameCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"LeftMenuUserNameCell";
      self.backgroundColor = [AppUtils separatorsColor];
      self.staticHeightForCell = 50.0f;
  }
  return self;
}

@end


@implementation LeftMenuUserNameCell

- (void)setUpWithSource:(LeftMenuUserNameCellSource*)source
{
    _userImage.backgroundColor = [AppUtils blueBackgroundColor];
    _nameLabel.backgroundColor = [AppUtils blueBackgroundColor];
    _nameLabel.text = [[MainUser mainUser].user.username uppercaseString];
    
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
}

@end




