//
//  StalkersCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface StalkersCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface StalkersCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (void)setUpWithSource:(StalkersCellSource*)source;
@end

