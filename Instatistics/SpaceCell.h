//
//  SpaceCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface SpaceCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface SpaceCell : ImoDynamicDefaultCellExtended
- (void)setUpWithSource:(SpaceCellSource*)source;
@end

