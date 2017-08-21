//
//  BuyItemsCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface BuyItemsCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) NSString * leesString;
@property (nonatomic,assign) NSInteger cellTag;
@end

@interface BuyItemsCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *lessLabel;
- (void)setUpWithSource:(BuyItemsCellSource*)source;
@end

