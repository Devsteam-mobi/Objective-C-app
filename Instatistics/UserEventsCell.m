//
//  UserEventsCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserEventsCell.h"
#import "AppUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIButton+InfoObject.h"
@implementation UserEventsCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserEventsCell";
      self.backgroundColor = [UIColor whiteColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 55.0f;
  }
  return self;
}

@end


@implementation UserEventsCell

- (void)setUpWithSource:(UserEventsCellSource*)source
{
    _userImage.layer.cornerRadius = _userImage.frame.size.height/2.0;
    _userImage.clipsToBounds = YES;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:source.user.profile_picture]];
    
    
    _separatorImage.backgroundColor = [AppUtils separatorsColor];
    if (source.isSelected) {
    _separatorImage.backgroundColor = [UIColor clearColor];
    }
    
    
    

    
    NSString * name = [source.user.full_name uppercaseString];
    NSString * nickName = source.user.username;
    NSString * event = @"";
    NSString * event2 = @"";
    switch (source.userEventType) {
        case _new_followers:
            event = @"Follows You";
            break;
        
        case _lost_followers:
            event = @"";
            break;
        case _new_followings:
            event = @"You follow";
            break;
        case _mutual:
            event = @"Follows You";
            event2 = @"You follow";
            break;
        case _not_following_me_back:
            event = @"You follow";
            break;
        case _i_am_not_following_back:
            event = @"Follows You";
            break;
        case _deleted_comments:
            event = @"This user deleted his comment";
            break;
        case _deleted_likes:
            event = @"This user deleted his like";
            break;
        default:
            break;
    }
    
    
    _postTextLabel.textColor = [AppUtils commentsTextColor];
    
    NSString * fullString = [NSString stringWithFormat:@"%@\n%@\n%@  %@", name, nickName,event,event2];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString new] initWithString:fullString];
    
    
    if (source.userEventType == _deleted_comments || source.userEventType ==  _deleted_likes) {
        if (event.length) {
            [attrString addAttribute:NSForegroundColorAttributeName value:[AppUtils userActionColor] range:[fullString rangeOfString:event]];
            [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_regular size:11] range:[fullString rangeOfString:event]];
        }
        
    }
    else
    {
        if (event.length) {
            [attrString addAttribute:NSForegroundColorAttributeName value:[AppUtils blueBackgroundColor] range:[fullString rangeOfString:event]];
            [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_black size:11] range:[fullString rangeOfString:event]];
        }
        
        if (event2.length) {
            [attrString addAttribute:NSForegroundColorAttributeName value:[AppUtils followGreenColor] range:[fullString rangeOfString:event2]];
            [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_black size:11] range:[fullString rangeOfString:event2]];
        }
    }
    
    
    

    
    
    [attrString addAttribute:NSForegroundColorAttributeName value:[AppUtils commentsTextColor] range:[fullString rangeOfString:name]];
    [attrString addAttribute:NSForegroundColorAttributeName value:[AppUtils commentsTextColor] range:[fullString rangeOfString:nickName]];
    
    
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_regular size:11] range:[fullString rangeOfString:nickName]];
    
    
    _postTextLabel.attributedText = attrString;
    
    
  
    
     if (source.showDistance == NO) {
    NSMutableAttributedString *likesAttributedString = [[NSMutableAttributedString new] initWithString:[NSString stringWithFormat:@" %lu", (unsigned long)source.eventsCount]];
    NSTextAttachment *textLikesAttachment = [[NSTextAttachment alloc] init];
    textLikesAttachment.image = source.userEventType == _deleted_comments ? [UIImage imageNamed:@"blueCommentsIcon"] : [UIImage imageNamed:@"redHeartImage"];
    CGFloat offsetY = -2.0;
    textLikesAttachment.bounds = CGRectMake(0, offsetY, textLikesAttachment.image.size.width, textLikesAttachment.image.size.height);
    NSAttributedString *attrStringWithLikeImage = [NSAttributedString attributedStringWithAttachment:textLikesAttachment];
    [likesAttributedString  insertAttributedString:attrStringWithLikeImage atIndex:0];
    _likesLabel.attributedText = likesAttributedString;
     }
    

    
    if (source.showDistance) {
        _likesLabel.text = [NSString stringWithFormat:@"%lu km",(unsigned long)source.eventsCount];
    }
    
    _selectButton.infoObject = source.user;
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    
    
    _profileButton.infoObject = source.user;
    [_profileButton removeTarget:source.target action:source.profileSelector forControlEvents:UIControlEventAllEvents];
    [_profileButton addTarget:source.target action:source.profileSelector forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = source.backgroundColor;
}

@end




