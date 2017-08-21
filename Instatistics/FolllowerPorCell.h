//
//  FolllowerPorCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface FolllowerPorCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface FolllowerPorCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UILabel *proLabel;
- (void)setUpWithSource:(FolllowerPorCellSource*)source;
@end

