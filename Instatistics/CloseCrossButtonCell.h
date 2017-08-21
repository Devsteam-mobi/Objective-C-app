//
//  CloseCrossButtonCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface CloseCrossButtonCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface CloseCrossButtonCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
- (void)setUpWithSource:(CloseCrossButtonCellSource*)source;
@end

