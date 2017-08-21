//
//  LeftMenuView.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 12/2/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "LeftMenuView.h"
#import "LeftMenuItemCell.h"
#import "BaseNavigationController.h"
#import "BaseTableViewController.h"


@implementation LeftMenuView


- (void)drawRect:(CGRect)rect {
    
    _tableView.backgroundColor = [AppUtils appBackgroundColor];
}



-(IBAction)hideMenu:(id)sender
{
    [_target hideLeftMenuView];
}


-(void)buildInterface
{
    
    NSInteger selectedIndex = [(BaseViewController*)_target startPage].selectedIndex;
    
    NSMutableArray *section = [NSMutableArray new];
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 44;
        [section addObject:cellSource];
    }
    
    
    MainUser * curentUser = [MainUser mainUser];
    MainUser * previousUser = [MainUser previousUser];
    
    NSTimeInterval lastWeekInterval = [[NSDate date] timeIntervalSince1970] - 60 * 60 * 24 * 7;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.created_time > %ld",(long)lastWeekInterval];
    
    RLMResults * newPhotos = [curentUser.photos objectsWithPredicate:predicate];
    RLMResults * newVideos = [curentUser.videos objectsWithPredicate:predicate];
    NSInteger newPosts = newPhotos.count + newVideos.count;
    
    
    NSInteger newLikes = curentUser.likes.count - previousUser.likes.count;
    newLikes = newLikes > 0 ? newLikes : 0;
    
    
    NSArray * menuItemsInfo = @[
                                @{@"title" : [(BaseViewController*)_target mainUser].user.username,
                                  @"image" : @"userFormWhiteIcon",
                                  @"itemTag" : @"0"
                                  },
                                @{@"title" : @"POSTS",
                                  @"subtitle" : newPosts > 0 ? [NSString stringWithFormat:@"%ld new posts this week",(long)newPosts] : @"No posts this weak",
                                  @"image" : @"postsItemImage",
                                  @"itemTag" : @"1"
                                  },
                                @{@"title" : @"AUDIENCE",
                                  @"subtitle" : curentUser.userNewFollowers.count ? [NSString stringWithFormat:@"You have %ld new followers",(long)curentUser.userNewFollowers.count] : @"You have not new followers",
                                  @"image" : @"audienceItemImage",
                                  @"itemTag" : @"2"
                                  },
                                @{@"title" : @"ENGAGEMENT",
                                  @"subtitle" : newLikes ? [NSString stringWithFormat:@"You have %ld new likes",(long)newLikes] : @"You have not new likes",
                                  @"image" : @"engagementItemImage",
                                  @"itemTag" : @"3"
                                  },
                               
                                @{@"title" : @"TERMS & POLICY",
                                  @"image" : @"termsAndPolicyIconImage",
                                  @"itemTag" : @"4"
                                  },
                               
                               
                                ];
    
    int itemIndex = 0;
    for (NSDictionary * dict in menuItemsInfo) {
        
        {
            LeftMenuItemCellSource *cellSource = [LeftMenuItemCellSource new];
            cellSource.target = self;
            cellSource.itemInfo = dict;
            cellSource.selector = @selector(menuItemSelected:);
            cellSource.isSelected = itemIndex == selectedIndex;
            [section addObject:cellSource];
            if (itemIndex > 3) {
                cellSource.titleColor = [AppUtils grayItemTextColor];
            }
            
            if (itemIndex == 3) {
                {
                    SpaceCellSource *cellSource = [SpaceCellSource new];
                    cellSource.staticHeightForCell = 20;
                    [section addObject:cellSource];
                }
            }
            itemIndex++;
        }
    }
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 20;
        [section addObject:cellSource];
    }
   
    

    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
}


-(void)menuItemSelected:(UIButton*)sender
{
    BaseViewController * controller = (BaseViewController*)_target;
    BaseNavigationController * navigationController = (BaseNavigationController*)controller.navigationController;
    StartPageViewController * startPage = navigationController.startViewController;
    [startPage leftMenuItemSelected:sender];
}


@end
