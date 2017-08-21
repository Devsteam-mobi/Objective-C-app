//
//  LeftMenuUserNameCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "InstagramAPI.h"

@interface LeftMenuUserNameCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;

@end

@interface LeftMenuUserNameCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
- (void)setUpWithSource:(LeftMenuUserNameCellSource*)source;
@end

