//
//  MultiLineStringCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface MultiLineStringCellSource : IDDCellSource

@property (retain, nonatomic)  NSString *infoText;
@property (assign, nonatomic)  UIFont* font;
@property (assign, nonatomic)  NSTextAlignment textAlignment;
@property (nonatomic, retain)  UIColor *textColor;
@property (nonatomic, retain)  UIColor *backgroundColor;
@end

@interface MultiLineStringCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


- (void)setUpWithSource:(MultiLineStringCellSource*)source;
@end

