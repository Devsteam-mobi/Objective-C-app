//
//  UserPhotosCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserPhotosCell.h"
#import "AppUtils.h"
#import "PhotoItemCell.h"
#import "AppConstants.h"
#import "InstagramAPI.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@implementation UserPhotosCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserPhotosCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 76.0f;
  }
  return self;
}

@end


@implementation UserPhotosCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _itemsArrray = [NSMutableArray new];
    }
    return self;
}


- (void)setUpWithSource:(UserPhotosCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _source = source;
    
    if (_bottomRefreshControl == nil) {
        _bottomRefreshControl = [[UIRefreshControl alloc] init];
        [_bottomRefreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        self.collectionView.bottomRefreshControl = _bottomRefreshControl;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotoItemCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    _nextMaxId = @"";
    
    [self refresh:_bottomRefreshControl];
}


-(void)refresh:(UIRefreshControl*)refreshControl
{
    if (refreshControl.tag != 0) {
        [refreshControl endRefreshing];
        return;
    }
    [self getPhotosForId:_nextMaxId];
}


-(void)getPhotosForId:(NSString*)nextId
{
    
    
    [[InstagramAPI sharedInstance] getUserFeed:_source.user.Id count:0 maxId:nextId getComments:NO comp:^(NSArray *response, IGPagination *pagination) {
        _bottomRefreshControl.tag = [[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""];
        _nextMaxId = pagination.nextMaxId;
        [_itemsArrray addObjectsFromArray:response];
        [self.collectionView reloadData];
        [_bottomRefreshControl endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark <UICollectionViewDataSource>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 0, 1, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (collectionView.frame.size.width - 6) / 3.0f;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _itemsArrray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PhotoItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoItemCell" forIndexPath:indexPath];
    cell.target = _source.target;
    [cell setupWithItem:_itemsArrray[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


// //Uncomment this method to specify if the specified item should be highlighted during tracking
// - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//	return YES;
// }
// 
//
//
// // Uncomment this method to specify if the specified item should be selected
// - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
// return YES;
// }


/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end




