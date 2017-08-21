//
//  SeparatorCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "SeparatorCell.h"
#import "AppUtils.h"
@implementation SeparatorCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"SeparatorCell";
      self.backgroundColor = [AppUtils separatorsColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 0.5f;
  }
  return self;
}

@end


@implementation SeparatorCell

- (void)setUpWithSource:(SeparatorCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
}

@end




