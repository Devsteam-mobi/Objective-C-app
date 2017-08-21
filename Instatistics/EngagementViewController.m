//
//  EngagementViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "EngagementViewController.h"
#import "AppDelegate.h"
#import "CustomInputView.h"
#import "UserStatisticsTopMenuItem.h"
#import "UserStatisticsHorisontalInfoCell.h"
#import "UserStatisticsFollowInfoCell.h"
#import "LeftMenuView.h"
#import "UnlockedWithCell.h"
#import "HeaderItemCell.h"
#import "AudienceMenuItemCell.h"
#import "UserEngagementTopsViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface EngagementViewController ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation EngagementViewController






-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"ENGAGEMENT";
    self.tableView.scrollEnabled = YES;
    [self buildInterface];
}




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImage *leftButtonImage = [UIImage imageNamed:@"menuButtonImage"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftButton;

    // ** Don't forget to add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
   
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _userLocation = [locations lastObject];
}


-(void)buildInterface
{

    NSMutableArray *section = [NSMutableArray new];
    
    
    BOOL showLockedItems = [AppUtils showLockedItems];
    if (showLockedItems) {
        {
            UnlockedWithCellSource * cellSource = [UnlockedWithCellSource new];
            cellSource.selector = @selector(openUpgradeViewController:);
            cellSource.target = self;
            [section addObject:cellSource];
        }
    }
    
    NSArray * grayItemsInfo = @[
                                @{@"title" : @"Photos",
                                  @"image" : @"photosIconImage",
                                  @"items" : @[@{@"title" : @"Most Engagement, Last 7 Days",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Most Engagement, Last 30 Days",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Most Engagement, All Time",
                                                 @"image" : @"lockIconImage"
                                                 }
                                               ]
                                  
                                  },
                                @{@"title" : @"Videos",
                                  @"image" : @"videosIconImage",
                                  @"items" : @[@{@"title" : @"Most Engagement, Last 7 Days",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Most Engagement, Last 30 Days",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Most Engagement, All Time",
                                                 @"image" : @"lockIconImage"
                                                 }
                                               ]
                                  },
                                @{@"title" : @"Nearest Followers",
                                  @"image" : @"closestFollowersIconImage",
                                  @"items" : @[
                                               @{@"title" : @"Nearest to me",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Farthest from me",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               ]
                                  },
                                
                                @{@"title" : @"Ghosts",
                                  @"image" : @"ghostsIconImage",
                                  @"items" : @[@{@"title" : @"Ghost Followers",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Least Likes Given",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Least Comments Left",
                                                 @"image" : @"lockIconImage"
                                                 }
                                               ]
                                  }
                                ];
    
    
    
    NSInteger index = 0;
    for (NSDictionary * dict in grayItemsInfo) {
        
        {
            HeaderItemCellSource *cellSource = [HeaderItemCellSource new];
            cellSource.itemInfo = dict;
            [section addObject:cellSource];
            
            for (NSDictionary * sectionItem in dict[@"items"])
            {
                {
                    AudienceMenuItemCellSource *cellSource = [AudienceMenuItemCellSource new];
                    cellSource.itemInfo = sectionItem;
                    cellSource.selector = showLockedItems ? @selector(openUpgradeViewController:) : @selector(itemSelected:);
                    cellSource.target = self;
                    cellSource.cellTag = index;
                    [section addObject:cellSource];
                    
                }
                {
                    SeparatorCellSource *cellSource = [SeparatorCellSource new];
                    cellSource.backgroundColor = [AppUtils appBackgroundColor];
                    [section addObject:cellSource];
                    
                }
                index ++;

            }
        }
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
}




-(void)itemSelected:(UIButton*)sender
{
    
    [self performSegueWithIdentifier:segue_showUserEngagementTops sender:@(sender.tag)];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:segue_showUserEngagementTops]) {
        
        UserEngagementTopsViewController* tops = segue.destinationViewController;
        tops.selectedItem = [sender integerValue];
        tops.userLocation = _userLocation;
    }
}


@end
