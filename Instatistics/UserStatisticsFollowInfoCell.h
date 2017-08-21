//
//  UserStatisticsFollowInfoCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>


@interface UserStatisticsFollowInfoCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface UserStatisticsFollowInfoCell : ImoDynamicDefaultCellExtended <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)  NSMutableArray * itemsArrray;
@property (strong, nonatomic)  UserStatisticsFollowInfoCellSource *source;
- (void)setUpWithSource:(UserStatisticsFollowInfoCellSource*)source;

@end

