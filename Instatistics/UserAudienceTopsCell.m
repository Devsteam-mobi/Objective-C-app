//
//  UserAudienceTopsCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserAudienceTopsCell.h"
#import "AppUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIButton+InfoObject.h"
#import "AppConstants.h"


@implementation UserAudienceTopsCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserAudienceTopsCell";
      self.backgroundColor = [UIColor whiteColor];
      self.multipleSelection = YES;
      self.showCommentsCount = YES;
      //self.staticHeightForCell = 55.0f;
  }
  return self;
}

@end


@implementation UserAudienceTopsCell

- (void)setUpWithSource:(UserAudienceTopsCellSource*)source
{
    _likesLabel.alpha = source.showLikesAndCommentsCount;
    _commentsLabel.alpha = source.showLikesAndCommentsCount && source.showCommentsCount;
    _separatorImage.backgroundColor = [AppUtils separatorsColor];
    if (source.isSelected) {
        _separatorImage.backgroundColor = [UIColor clearColor];
    }
    _userImage.layer.cornerRadius = _userImage.frame.size.height/2.0;
    _userImage.clipsToBounds = YES;
    _userImage.image = nil;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:source.user.profile_picture]];
    _separatorImage.backgroundColor = [AppUtils separatorsColor];
    
    
    NSString * name = [source.user.full_name uppercaseString];
    NSString * nickName = source.user.username;
    
    
    NSString * fullString = [NSString stringWithFormat:@"%@\n%@", name, nickName];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString new] initWithString:fullString];
    [attrString addAttribute:NSForegroundColorAttributeName value:[AppUtils commentsTextColor] range:[fullString rangeOfString:[AppUtils validateString:name]]];
    [attrString addAttribute:NSForegroundColorAttributeName value:[AppUtils commentsTextColor] range:[fullString rangeOfString:[AppUtils validateString:nickName]]];
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_regular size:11] range:[fullString rangeOfString:[AppUtils validateString:nickName]]];
    
    
    _postTextLabel.attributedText = attrString;
    
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString new] initWithString:[NSString stringWithFormat:@" %ld", source.commentsCount]];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    CGFloat offsetY = -3.0;
    textAttachment.image = [UIImage imageNamed:@"blueCommentsIcon"];
    textAttachment.bounds = CGRectMake(0, offsetY, textAttachment.image.size.width, textAttachment.image.size.height);
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString  insertAttributedString:attrStringWithImage atIndex:0];
    
    
    
    NSMutableAttributedString *likesAttributedString = [[NSMutableAttributedString new] initWithString:[NSString stringWithFormat:@" %ld", source.likesCount]];
    NSTextAttachment *textLikesAttachment = [[NSTextAttachment alloc] init];
    textLikesAttachment.image = [UIImage imageNamed:@"redHeartImage"];
    textLikesAttachment.bounds = CGRectMake(0, offsetY, textLikesAttachment.image.size.width, textLikesAttachment.image.size.height);
    NSAttributedString *attrStringWithLikeImage = [NSAttributedString attributedStringWithAttachment:textLikesAttachment];
    [likesAttributedString  insertAttributedString:attrStringWithLikeImage atIndex:0];
    
    
    _commentsLabel.attributedText = attributedString;
    _likesLabel.attributedText = likesAttributedString;
    
    
    _profileUserButton.infoObject = source.user;
    [_profileUserButton removeTarget:source.target action:source.profileSelector forControlEvents:UIControlEventAllEvents];
    [_profileUserButton addTarget:source.target action:source.profileSelector forControlEvents:UIControlEventTouchUpInside];
    
    _selectButton.infoObject = source.user;
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = source.backgroundColor;
}

@end




