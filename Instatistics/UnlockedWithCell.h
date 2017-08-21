//
//  UnlockedWithCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface UnlockedWithCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface UnlockedWithCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIButton *upgradeButton;
@property (weak, nonatomic) IBOutlet UILabel *proLabel;
@property (weak, nonatomic) IBOutlet UILabel *unlockedLabel;
- (void)setUpWithSource:(UnlockedWithCellSource*)source;
@end

