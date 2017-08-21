//
//  UserProfileHeaderCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "IGUser.h"

@interface UserProfileHeaderCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) IGUser * user;

@end

@interface UserProfileHeaderCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIButton *folllowButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *photosCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;
@property (nonatomic,retain) UserProfileHeaderCellSource * source;
- (void)setUpWithSource:(UserProfileHeaderCellSource*)source;
@end

