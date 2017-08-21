//
//  UserAudienceTopsCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "IGUser.h"

@interface UserAudienceTopsCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) IGUser * user;
@property (nonatomic,assign) SEL profileSelector;
@property (nonatomic,assign) BOOL  isSelected;
@property (nonatomic,assign) NSInteger likesCount;
@property (nonatomic,assign) NSInteger commentsCount;
@property (nonatomic,assign) BOOL  showLikesAndCommentsCount;
@property (nonatomic,assign) BOOL  showCommentsCount;
@end

@interface UserAudienceTopsCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIButton *profileUserButton;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *separatorImage;
@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
- (void)setUpWithSource:(UserAudienceTopsCellSource*)source;
@end

