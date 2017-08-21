//
//  UserStatisticsTopMenuItem.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramAPI.h"


@interface UserStatisticsTopMenuItem : UIView
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong) MainUser *mainUser;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (nonatomic,retain) id target;

@end
