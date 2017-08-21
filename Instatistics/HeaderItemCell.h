//
//  HeaderItemCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "InstagramAPI.h"

@interface HeaderItemCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) NSDictionary * itemInfo;
@end

@interface HeaderItemCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
- (void)setUpWithSource:(HeaderItemCellSource*)source;
@end

