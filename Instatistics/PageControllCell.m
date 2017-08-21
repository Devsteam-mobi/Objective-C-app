//
//  PageControllCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "PageControllCell.h"
#import "AppUtils.h"
#import "PageControllCollectionCell.h"
#import "UpgradeViewController.h"

@implementation PageControllCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"PageControllCell";
        self.backgroundColor = [UIColor clearColor];
        self.multipleSelection = YES;
        self.staticHeightForCell = ([AppUtils isIphoneVersion:4] ? 130 : 170) + 165.5;
        _titlesArray = @[@{@"title" : @"",
                           @"description" : @"Subscribe to access the best engagement analytics and daily scan tool to help you grow your brand and influence."},
                         @{@"title" : @"Daily Scan",
                           @"description" :@"Never miss a beat. Let our cloud analytics refresh your data and followers, everyday, automatically."},
                         @{@"title" : @"Audience",
                           @"description" :@"Better understand your followers through location and behavioral data about them."},
                         @{@"title" : @"Engagement",
                           @"description" :@"Discover your best and most engaged followers. Reactivate ones that have gone “ghost”."},
                         @{@"title" : @"Loss Reports",
                           @"description" :@"Learn who is unfollowing or blocking you, posting and deleting comments, or even unliking your photos."},
                         @{@"title" : @"Multiple Accounts",
                           @"description" :@"Track followers and account analytics for up to 3 accounts."}
                         ];
    }
    return self;
}

@end


@implementation PageControllCell

- (void)setUpWithSource:(PageControllCellSource*)source
{
    _source = source;
    self.backgroundColor = source.backgroundColor;
    [_collectionView registerNib:[UINib nibWithNibName:@"PageControllCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PageControllCollectionCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:source.selectedTag inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}




#pragma mark <UICollectionViewDataSource>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(self.frame.size.width , _source.staticHeightForCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _source.titlesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PageControllCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PageControllCollectionCell" forIndexPath:indexPath];
    cell.target = _source.target;
    cell.selectedTag = indexPath.row;
    [cell setupWithItem:_source.titlesArray[indexPath.row]];
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UpgradeViewController * upgrade = _source.target;
    upgrade.selectedTag = (NSInteger)(scrollView.contentOffset.x/scrollView.frame.size.width);
    [upgrade buildInterface];
}

@end




