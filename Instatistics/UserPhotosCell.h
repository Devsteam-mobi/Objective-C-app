//
//  UserPhotosCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "IGUser.h"

@interface UserPhotosCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) IGUser * user;
@end

@interface UserPhotosCell : ImoDynamicDefaultCellExtended <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)  NSMutableArray * itemsArrray;
@property (strong, nonatomic)  UserPhotosCellSource *source;
@property (strong, nonatomic)  NSString *nextMaxId;
@property (nonatomic, strong) UIRefreshControl *bottomRefreshControl;
- (void)setUpWithSource:(UserPhotosCellSource*)source;

@end

