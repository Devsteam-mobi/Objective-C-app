//
//  UserEventsExtendedLikeCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserEventsExtendedLikeCell.h"
#import "AppUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "InstagramAPI.h"
#import "UIButton+InfoObject.h"

@implementation UserEventsExtendedLikeCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserEventsExtendedLikeCell";
      self.backgroundColor = [UIColor whiteColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 120.0f;
      
  }
  return self;
}

@end


@implementation UserEventsExtendedLikeCell

- (void)setUpWithSource:(UserEventsExtendedLikeCellSource*)source
{
    _userImage.image = nil;
    [[InstagramAPI sharedInstance] getMedia:source.liker.mediaId comp:^(IGMedia *media) {
        [_userImage sd_setImageWithURL:[NSURL URLWithString:media.image.low_resolution]];
        _selectButton.infoObject = media;
    } failure:^(NSError *error) {
        
    }];
    
    
    _separatorImage.backgroundColor = [AppUtils separatorsColor];
    
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = source.backgroundColor;
}

@end




