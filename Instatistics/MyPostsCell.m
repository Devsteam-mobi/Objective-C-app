//
//  MyPostsCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "MyPostsCell.h"
#import "AppUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIButton+InfoObject.h"

@implementation MyPostsCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"MyPostsCell";
      self.backgroundColor = [UIColor whiteColor];
      self.multipleSelection = YES;
      //self.staticHeightForCell = 55.0f;
  }
  return self;
}

@end


@implementation MyPostsCell

- (void)setUpWithSource:(MyPostsCellSource*)source
{
    _userImage.layer.cornerRadius = _userImage.frame.size.height/2.0;
    _userImage.clipsToBounds = YES;
    _userImage.image = nil;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:source.media.image.low_resolution]];
    _separatorImage.backgroundColor = [AppUtils separatorsColor];
    _postTextLabel.textColor = [AppUtils commentsTextColor];
    
    _postTextLabel.text = @"No comment";
    
    if (source.media.caption.text.length) {
        _postTextLabel.text = source.media.caption.text;
    }
    
    
    
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString new] initWithString:[NSString stringWithFormat:@" %@", source.media.comment_count]];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    CGFloat offsetY = -3.0;
    textAttachment.image = [UIImage imageNamed:@"blueCommentsIcon"];
    textAttachment.bounds = CGRectMake(0, offsetY, textAttachment.image.size.width, textAttachment.image.size.height);
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString  insertAttributedString:attrStringWithImage atIndex:0];
    
    
    
    NSMutableAttributedString *likesAttributedString = [[NSMutableAttributedString new] initWithString:[NSString stringWithFormat:@" %@", source.media.likes_count]];
    NSTextAttachment *textLikesAttachment = [[NSTextAttachment alloc] init];
    textLikesAttachment.image = [UIImage imageNamed:@"redHeartImage"];
    textLikesAttachment.bounds = CGRectMake(0, offsetY, textLikesAttachment.image.size.width, textLikesAttachment.image.size.height);
    NSAttributedString *attrStringWithLikeImage = [NSAttributedString attributedStringWithAttachment:textLikesAttachment];
    [likesAttributedString  insertAttributedString:attrStringWithLikeImage atIndex:0];
    
    
    _commentsLabel.attributedText = attributedString;
    _likesLabel.attributedText = likesAttributedString;
    
    _selectButton.infoObject = source.media;
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = source.backgroundColor;
}

@end




