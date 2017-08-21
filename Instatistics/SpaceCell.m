//
//  SpaceCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "SpaceCell.h"


@implementation SpaceCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"SpaceCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 20;
  }
  return self;
}

@end


@implementation SpaceCell

- (void)setUpWithSource:(SpaceCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
}

@end




