//
//  LeftMenuItemCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "InstagramAPI.h"

@interface LeftMenuItemCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) NSDictionary * itemInfo;
@property (nonatomic,retain) UIColor * titleColor;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface LeftMenuItemCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
- (void)setUpWithSource:(LeftMenuItemCellSource*)source;
@end

