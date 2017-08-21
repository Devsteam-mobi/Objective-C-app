//
//  FolllowerPorCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "FolllowerPorCell.h"
#import "AppUtils.h"


@implementation FolllowerPorCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"FolllowerPorCell";
      self.backgroundColor = [UIColor clearColor];
      self.staticHeightForCell = 30;
  }
  return self;
}

@end


@implementation FolllowerPorCell

- (void)setUpWithSource:(FolllowerPorCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    
    _proLabel.layer.borderColor = [AppUtils blueBackgroundColor].CGColor;
    _proLabel.layer.borderWidth = 1.0;
  }

@end




