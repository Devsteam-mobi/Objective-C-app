//
//  PageControllCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface PageControllCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) NSArray *titlesArray;
@property (nonatomic,assign) NSInteger selectedTag;
@end

@interface PageControllCell : ImoDynamicDefaultCellExtended <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,retain) PageControllCellSource *source;
- (void)setUpWithSource:(PageControllCellSource*)source;
@end

