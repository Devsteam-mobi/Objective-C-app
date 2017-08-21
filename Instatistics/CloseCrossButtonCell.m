//
//  CloseCrossButtonCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "CloseCrossButtonCell.h"


@implementation CloseCrossButtonCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"CloseCrossButtonCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 25;
  }
  return self;
}

@end


@implementation CloseCrossButtonCell

- (void)setUpWithSource:(CloseCrossButtonCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    [_closeButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_closeButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
}

@end




