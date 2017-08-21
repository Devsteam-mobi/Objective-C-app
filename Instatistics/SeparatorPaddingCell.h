//
//  SeparatorPaddingCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface SeparatorPaddingCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,assign) NSInteger padding;
@end

@interface SeparatorPaddingCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftPadding;
@property (weak, nonatomic) IBOutlet UIImageView *separatorImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightPadding;
- (void)setUpWithSource:(SeparatorPaddingCellSource*)source;
@end

