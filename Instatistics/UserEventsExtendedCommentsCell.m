//
//  UserEventsExtendedCommentsCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserEventsExtendedCommentsCell.h"
#import "AppUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "InstagramAPI.h"
#import "UIButton+InfoObject.h"

@implementation UserEventsExtendedCommentsCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserEventsExtendedCommentsCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 120.0f;
  }
  return self;
}

@end


@implementation UserEventsExtendedCommentsCell

- (void)setUpWithSource:(UserEventsExtendedCommentsCellSource*)source
{
    [[InstagramAPI sharedInstance] getMedia:source.comment.mediaId comp:^(IGMedia *media) {
    [_userImage sd_setImageWithURL:[NSURL URLWithString:media.image.low_resolution]];
        _selectButton.infoObject = media;
    } failure:^(NSError *error) {
        
    }];
    
    _separatorImage.backgroundColor = [AppUtils separatorsColor];
    _postTextLabel.text = source.comment.text;
    _postTextLabel.textColor = [AppUtils commentsTextColor];
  
    
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = source.backgroundColor;
}

@end




