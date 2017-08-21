//
//  UnlockedWithCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UnlockedWithCell.h"
#import "AppUtils.h"


@implementation UnlockedWithCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UnlockedWithCell";
      self.backgroundColor = [AppUtils lightBlackColor];
      self.staticHeightForCell = 155;
  }
  return self;
}

@end


@implementation UnlockedWithCell

- (void)setUpWithSource:(UnlockedWithCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _unlockedLabel.textColor = [AppUtils unlockWithTextColor];
    _proLabel.layer.borderColor = [AppUtils blueBackgroundColor].CGColor;
    _proLabel.layer.borderWidth = 1.0;
    
    _upgradeButton.layer.cornerRadius = _upgradeButton.frame.size.height/2.0f;
    _upgradeButton.layer.borderWidth = 0.5;
    _upgradeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    [_upgradeButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_upgradeButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
}

@end




