//
//  ImageViewCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "ImageViewCell.h"
#import "AppUtils.h"

@implementation ImageViewCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"ImageViewCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 140;
  }
  return self;
}

@end


@implementation ImageViewCell

- (void)setUpWithSource:(ImageViewCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    [_actionImageView setContentMode: [AppUtils isIphoneVersion:4] ? UIViewContentModeScaleAspectFit : UIViewContentModeCenter];
    [_actionImageView setImage:[UIImage imageNamed:[@"upgradeImage" stringByAppendingFormat:@"%ld",source.tag]]];
}

@end




