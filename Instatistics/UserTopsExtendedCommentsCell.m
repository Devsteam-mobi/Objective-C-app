//
//  UserTopsExtendedCommentsCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserTopsExtendedCommentsCell.h"
#import "AppUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "InstagramAPI.h"
#import "UIButton+InfoObject.h"

@implementation UserTopsExtendedCommentsCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserTopsExtendedCommentsCell";
      self.backgroundColor = [UIColor whiteColor];
      //self.staticHeightForCell = 120.0f;
  }
  return self;
}

@end


@implementation UserTopsExtendedCommentsCell

- (void)setUpWithSource:(UserTopsExtendedCommentsCellSource*)source
{
    if (source.comments.count) {
        IGComment * comment = source.comments[0];
        [[InstagramAPI sharedInstance] getMedia: comment.mediaId comp:^(IGMedia *media) {
            [_userImage sd_setImageWithURL:[NSURL URLWithString:media.image.low_resolution]];
            _selectButton.infoObject = media;
        } failure:^(NSError *error) {
            
        }];
    }
    
    
    
    _likeImage.image = source.liked ? [UIImage imageNamed:@"bigRedLikeHeart"] : [UIImage imageNamed:@"bigGrayLikeHeart"];
    
    _separatorImage.backgroundColor = [AppUtils separatorsColor];
    
    _postTextLabel.text = @"";
    for (IGComment *comment in source.comments) {
    _postTextLabel.text = [_postTextLabel.text stringByAppendingFormat:@"%@\n\n",comment.text];
    }
    
    _postTextLabel.textColor = [AppUtils commentsTextColor];
  
    
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = source.backgroundColor;
}

@end




