//
//  UserStatisticsFollowInfoCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserStatisticsFollowInfoCell.h"
#import "AppUtils.h"
#import "FollowMenuCell.h"
#import "AppConstants.h"
#import "VerticalMenuItem.h"
#import "MainUser.h"
#import "InstagramAPI.h"



@implementation UserStatisticsFollowInfoCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserStatisticsFollowInfoCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 76.0f;
  }
  return self;
}

@end


@implementation UserStatisticsFollowInfoCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _itemsArrray = [NSMutableArray new];
        
        
        
    }
    return self;
}


- (void)setUpWithSource:(UserStatisticsFollowInfoCellSource*)source
{
    
    _source = source;
    
    MainUser * currentUser = [MainUser mainUser];
    MainUser * firstRegisteredUser = [MainUser firstRegisteredUser];
    
    NSArray * iconsArray = @[@{@"icon" : @"newFallowersIconImage",
                               @"title" : @"NEW FOLLOWERS",
                               @"currentCount" : @(currentUser.userNewFollowers.count),
                               @"previousCount" : @(firstRegisteredUser.userFollowers.count)
                               },
                            
                             @{@"icon" : @"lostFallowersIconImage",
                               @"title" : @"LOST FOLLOWERS",
                               @"currentCount" : @(currentUser.userLostFollowers.count),
                               @"previousCount" : @(firstRegisteredUser.userLostFollowers.count)
                               
                               },
                             @{@"icon" : @"newFallowingsIconImage",
                               @"title" : @"NEW FOLLOWINGS",
                               @"currentCount" : @(currentUser.userNewFollowings.count),
                               @"previousCount" : @(firstRegisteredUser.userNewFollowings.count)
                               
                               },
                             @{@"icon" : @"mutualIconImage",
                               @"title" : @"MUTUAL",
                               @"currentCount" : @(currentUser.userMutualFollowers.count),
                               @"previousCount" : @(0)
                               
                               },
                             @{@"icon" : @"notFallowingIconImage",
                               @"title" : @"NOT FOLLOWING\nME BACK",
                               @"currentCount" : @(currentUser.usersNotFollowMeBack.count),
                               @"previousCount" : @(0)
                               },
                             @{@"icon" : @"newFallowersIconImage",
                               @"title" : @"I’M NOT\nFOLLOWING BACK",
                               @"currentCount" : @(currentUser.userIAmNotFollowingBack.count),
                               @"previousCount" : @(0)
                               
                               },
                             @{@"icon" : @"deletedIconImage",
                               @"title" : @"DELETED\nCOMMENTS",
                               @"currentCount" : @(currentUser.deletedComments.count),
                               @"previousCount" : @(firstRegisteredUser.deletedComments.count)
                               
                               },
                             @{@"icon" : @"deletedIconImage",
                               @"title" : @"DELETED\nLIKES",
                               @"currentCount" : @(currentUser.deletedLikes.count),
                               @"previousCount" : @(firstRegisteredUser.deletedLikes.count)
                               
                               }
                             ];
    
    [_itemsArrray removeAllObjects];
    for (NSDictionary * dict in iconsArray) {
        
        VerticalMenuItem * item = [[VerticalMenuItem new] initWithDictionary:dict];
        [_itemsArrray addObject:item];
        
    }

    self.backgroundColor = source.backgroundColor;
    _source = source;
    [_collectionView registerNib:[UINib nibWithNibName:@"FollowMenuCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FollowMenuCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.collectionView reloadData];
    
    
}









#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (collectionView.frame.size.width - 15) / 2.0f;
    return CGSizeMake(width, width - ([AppUtils isIphoneVersion:4] ? 0 : 35));
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _itemsArrray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FollowMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FollowMenuCell" forIndexPath:indexPath];
    cell.index = indexPath.row;
    cell.target = _source.target;
    [cell setupWithItem:_itemsArrray[indexPath.row]];
    return cell;
}



@end




