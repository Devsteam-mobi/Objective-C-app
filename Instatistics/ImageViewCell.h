//
//  ImageViewCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface ImageViewCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic, assign) NSInteger tag;
@end

@interface ImageViewCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIImageView *actionImageView;
- (void)setUpWithSource:(ImageViewCellSource*)source;
@end

