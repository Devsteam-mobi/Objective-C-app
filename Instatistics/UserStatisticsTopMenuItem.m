//
//  UserStatisticsTopMenuItem.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserStatisticsTopMenuItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppUtils.h"
#import "UserStatisticsViewController.h"

@implementation UserStatisticsTopMenuItem


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    _nameLabel.font = [UIFont fontWithName:_lato_font_black size:11];
    _nameLabel.textColor = [AppUtils topMenuTitleColor];
    
    _userImage.layer.cornerRadius = _userImage.frame.size.height/2.0f;
    _userImage.clipsToBounds = YES;
    _logoutButton.hidden = NO;
    if ([AppUtils isValidObject:self.mainUser] == NO) {
        _nameLabel.text = @"ADD ACCOUNT";
        [_userImage setImage:[UIImage imageNamed:@"addAccountIconImage"]];
    }
    
    else
    {
        [_userImage sd_setImageWithURL:[NSURL URLWithString:self.mainUser.user.profile_picture]];
        _nameLabel.text = [self.mainUser.user.username uppercaseString];
    }
    
    _logoutButton.hidden = _mainUser == nil;
    _selectButton.layer.borderWidth = 1.0f;
    _selectButton.layer.borderColor = [AppUtils separatorsColor].CGColor;
    self.clipsToBounds = YES;
}


- (IBAction)selectUser:(id)sender {
    
    UserStatisticsViewController * statistics = _target;
    [statistics selectUser:self.mainUser.user];
}


- (IBAction)logout:(id)sender {
   UserStatisticsViewController * statistics = _target;
    [statistics logout:_mainUser];
}


@end
