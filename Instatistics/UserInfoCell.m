//
//  UserInfoCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserInfoCell.h"
#import "AppUtils.h"

@implementation UserInfoCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserInfoCell";
      self.backgroundColor = [AppUtils lightBlackColor];
      self.multipleSelection = YES;

  }
  return self;
}

@end


@implementation UserInfoCell

- (void)setUpWithSource:(UserInfoCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _nameLabel.text = [source.user.full_name uppercaseString];
    _descriptionLabel.text = [NSString stringWithFormat:@"~%@~",source.user.bio];
    _urlLabel.text = source.user.website;
    _urlLabel.textColor = [AppUtils blueBackgroundColor];
}

@end




