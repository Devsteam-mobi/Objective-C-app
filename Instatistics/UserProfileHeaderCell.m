//
//  UserProfileHeaderCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserProfileHeaderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppUtils.h"
#import "AppConstants.h"
#import "MainUser.h"
#import "InstagramAPI.h"

@implementation UserProfileHeaderCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserProfileHeaderCell";
      self.backgroundColor = [AppUtils lightBlackColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 120.0f;
  }
  return self;
}

@end


@implementation UserProfileHeaderCell

- (void)setUpWithSource:(UserProfileHeaderCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _source = source;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:source.user.profile_picture]];
    _followLabel.layer.borderWidth = 1;
    _followLabel.layer.borderColor = [AppUtils greenBlueColor].CGColor;
    _followLabel.textColor = [AppUtils greenBlueColor];

    
    MainUser * currentUser = [MainUser mainUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",_source.user.Id];
    RLMResults * result = [currentUser.userFollowings objectsWithPredicate:predicate];
    
    [self changeButtonTitle:result.count];

    
    _photosCountLabel.text = [AppUtils minimizedCountString:[source.user.media_count integerValue]];
    _followersCountLabel.text = [AppUtils minimizedCountString:[source.user.followed_by_count integerValue]];
    _followingCountLabel.text = [AppUtils minimizedCountString:[source.user.follows_count integerValue]];
    
}


-(void)changeButtonTitle:(BOOL)iFollowHim
{
    _folllowButton.tag = iFollowHim;
    _followLabel.text = iFollowHim ? @"FOLLOWING" : @"FOLLOW";
    _infoLabel.text = iFollowHim ? @"You are following this user." : @"You are not following this user.";
}

-(IBAction)changeFollowState:(UIButton*)sender
{
    if (sender.tag == 0) {
        [[InstagramAPI sharedInstance] followUser:_source.user.Id comp:^(int response) {
            [self changeButtonTitle:response];
            [MainUser addItem:_source.user toArray:[MainUser mainUser].userFollowings];
        }];
    }
    else  {
        [[InstagramAPI sharedInstance] unfollowUser:_source.user.Id comp:^(int response) {
            MainUser * currentUser = [MainUser mainUser];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",_source.user.Id];
            RLMResults * result = [currentUser.userFollowings objectsWithPredicate:predicate];
            [[currentUser.userFollowings realm] beginWriteTransaction];
            [currentUser.userFollowings removeObjectAtIndex:[currentUser.userFollowings indexOfObject:[result objectAtIndex:0]]];
            [[currentUser.userFollowings realm] commitWriteTransaction];
            [self changeButtonTitle:!response];
        }];
    }
}



@end




