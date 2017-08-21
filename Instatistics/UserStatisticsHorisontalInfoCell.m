//
//  UserStatisticsHorisontalInfoCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserStatisticsHorisontalInfoCell.h"
#import "AppUtils.h"
#import "HorisontalMenuCell.h"
#import "HorisontalMenuItem.h"
#import "HorisontalMenuItemView.h"
#import "UserStatisticsViewController.h"


@implementation UserStatisticsHorisontalInfoCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserStatisticsHorisontalInfoCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 76.0f;
  }
  return self;
}

@end


@implementation UserStatisticsHorisontalInfoCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _itemsArrray = [NSMutableArray new];
    }
    return self;
}

- (void)setUpWithSource:(UserStatisticsHorisontalInfoCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _source = source;
    
    MainUser * previousUser = [MainUser previousUser];
     float previousPostsCount = 0;
    for (IGMedia *media in previousUser.photos) {
        NSTimeInterval aWeekAgo =[[NSDate date] timeIntervalSince1970] - 7 * 24 * 60 * 60;
        previousPostsCount += aWeekAgo < [media.created_time longLongValue] ? 1 : 0;
    }
    
    for (IGMedia *media in previousUser.videos) {
        
        NSTimeInterval aWeekAgo =[[NSDate date] timeIntervalSince1970] - 7 * 24 * 60 * 60;
        previousPostsCount += aWeekAgo < [media.created_time longLongValue] ? 1 : 0;
    }
    
    MainUser * currentUser = [MainUser mainUser];
    float currentPostsCount = 0;
    for (IGMedia *media in currentUser.photos) {
        NSTimeInterval aWeekAgo =[[NSDate date] timeIntervalSince1970] - 7 * 24 * 60 * 60;
        currentPostsCount += aWeekAgo < [media.created_time longLongValue] ? 1 : 0;
    }
    
    for (IGMedia *media in currentUser.videos) {
        
        NSTimeInterval aWeekAgo =[[NSDate date] timeIntervalSince1970] - 7 * 24 * 60 * 60;
        currentPostsCount += aWeekAgo < [media.created_time longLongValue] ? 1 : 0;
    }
    
    
    float currentMediaCount = currentUser.videos.count + currentUser.photos.count;
    float previousMediaCount = previousUser.videos.count + previousUser.photos.count;
    
    
    NSArray *infoArray = @[@{
                               @"title" : @"FOLLOWERS",
                               @"currentCount" : @(currentUser.userFollowers.count),
                               @"previousCount" : @(previousUser.userFollowers.count),
                               @"isFloat" : @(NO)
                               },
                           
                           @{
                               @"title" : @"FOLLOWING",
                               @"currentCount" : @(currentUser.userFollowings.count),
                               @"previousCount" : @(previousUser.userFollowings.count),
                               @"isFloat" : @(NO)
                               },

                           @{
                               @"title" : @"PHOTOS",
                               @"currentCount" : @(currentUser.photos.count),
                               @"previousCount" :@(previousUser.photos.count),
                               @"isFloat" : @(NO)
                               },
                           @{
                               @"title" : @"VIDEOS",
                               @"currentCount" : @(currentUser.videos.count),
                               @"previousCount" : @(previousUser.videos.count),
                               @"isFloat" : @(NO)
                               },
                           @{
                               @"title" : @"LIKES TOTAL",
                               @"currentCount" : @(currentUser.likes.count),
                               @"previousCount" : @(previousUser.likes.count),
                               @"isFloat" : @(NO)
                               },
                           @{
                               @"title" : @"COMMENTS TOTAL",
                               @"currentCount" : @(currentUser.comments.count),
                               @"previousCount" : @(previousUser.comments.count),
                               @"isFloat" : @(NO)
                               },
                           @{
                               @"title" : @"POSTS PER WEEK",
                               @"currentCount" : @(currentPostsCount),
                               @"previousCount" : @(previousPostsCount),
                               @"isFloat" : @(NO)
                               },
                           @{
                               @"title" : @"COMMENTS PER PHOTO",
                               @"currentCount" : @(currentMediaCount == 0 ? 0 : (float)currentUser.comments.count / currentMediaCount),
                               @"previousCount" : @(previousMediaCount == 0 ? 0 : (float)previousUser.comments.count / previousMediaCount),
                               @"isFloat" : @(YES)
                               },
                           @{
                               @"title" : @"LIKES PER PHOTO",
                               @"currentCount" : @(currentMediaCount == 0 ? 0 : (float)currentUser.likes.count / currentMediaCount),
                               @"previousCount" : @(previousMediaCount == 0 ? 0 : (float)previousUser.likes.count / previousMediaCount),
                               @"isFloat" : @(YES)
                               },
                           
//                           @{
//                               @"title" : @"POSTS ON HASHTAGS",
//                               @"currentCount" : @"",
//                               @"previousCount" : @"",
//                               }
                           ];

    
    [_itemsArrray removeAllObjects];
    for (NSDictionary* info in infoArray) {
        [_itemsArrray addObject:[[HorisontalMenuItem new] initWithDictionary:info]];
    }
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"HorisontalMenuCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HorisontalMenuCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView reloadData];
    
    if (_isRunning == NO) {
    [self performSelector:@selector(setBandToMiddlePosition) withObject:nil afterDelay:0.1];
    }
    
    
    
}


-(void)changeBandPosition
{
    
    if (self.collectionView.isDecelerating == NO && _isTracking == NO) {
        [self.collectionView setContentOffset:CGPointMake(_collectionView.contentOffset.x + 0.5, 0) animated:NO];
        
    }
    if (_collectionView.contentOffset.x  >= _collectionView.contentSize.width - self.frame.size.width) {
        [_collectionView setContentOffset:CGPointMake(_collectionView.contentSize.width/2.0f, 0) animated:NO];
    }
    _isRunning = YES;
   

    double delayInSeconds = 0.002;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self changeBandPosition];
    });

    

   
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isTracking = YES;
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _isTracking = NO;
}


-(void)setBandToMiddlePosition
{
    [_collectionView setContentOffset:CGPointMake(_collectionView.contentSize.width/2.0f, 0) animated:NO];

    {
        [self changeBandPosition];
    }
}



#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([AppUtils widthForStatisticsMenuItem:_itemsArrray[indexPath.row % 8]], 56.f);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _itemsArrray.count * 100;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HorisontalMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HorisontalMenuCell" forIndexPath:indexPath];
    [cell setupWithItem:_itemsArrray[indexPath.row % 8]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

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




