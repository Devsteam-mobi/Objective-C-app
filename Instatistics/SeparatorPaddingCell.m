//
//  SeparatorPaddingCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "SeparatorPaddingCell.h"
#import "AppUtils.h"
@implementation SeparatorPaddingCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"SeparatorPaddingCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 0.5f;
      self.padding = 30;
  }
  return self;
}

@end


@implementation SeparatorPaddingCell

- (void)setUpWithSource:(SeparatorPaddingCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _leftPadding.constant = _rightPadding.constant = source.padding;
    _separatorImage.backgroundColor = [UIColor whiteColor];
    _separatorImage.alpha = 0.14;
}

@end




