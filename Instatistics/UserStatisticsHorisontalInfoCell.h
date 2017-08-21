//
//  UserStatisticsHorisontalInfoCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "IGUser.h"
#import "MainUser.h"


@interface UserStatisticsHorisontalInfoCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface UserStatisticsHorisontalInfoCell : ImoDynamicDefaultCellExtended <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)  NSMutableArray * itemsArrray;
@property (nonatomic,retain) UserStatisticsHorisontalInfoCellSource * source;
@property (nonatomic,assign) BOOL isTracking;
@property (nonatomic,assign) BOOL isRunning;

- (void)setUpWithSource:(UserStatisticsHorisontalInfoCellSource*)source;


@end

