//
//  TabBarCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface TabBarCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,assign) NSInteger selectedTag;
@end

@interface TabBarCell : ImoDynamicDefaultCellExtended
- (void)setUpWithSource:(TabBarCellSource*)source;
@end

