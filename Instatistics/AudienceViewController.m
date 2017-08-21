//
//  AudienceViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "AudienceViewController.h"
#import "LeftMenuView.h"
#import "UnlockedWithCell.h"
#import "AudienceMenuItemCell.h"
#import "UserAudienceTopsViewController.h"
#import "HeaderItemCell.h"


@interface AudienceViewController ()

@end

@implementation AudienceViewController






-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"AUDIENCE";
    self.tableView.scrollEnabled = YES;
    
    [self buildInterface];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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

    
    [self.view layoutSubviews];
    
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
                                @{@"title" : @"Profile visitors",
                                  @"image" : @"comunityIconImage",
                                  @"items" : @[@{@"title" : @"Stalkers",
                                                 @"image" : @"lockIconImage"
                                                 }
                                               ]
                                  },

                                @{@"title" : @"Community",
                                  @"image" : @"comunityIconImage",
                                  @"items" : @[@{@"title" : @"Most Engaged",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Most Talkative",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               ]
                                  
                                  },
                                @{@"title" : @"Seasoned",
                                  @"image" : @"sesonedIconImage",
                                  @"items" : @[@{@"title" : @"Seasoned Instagram Users",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Newest Instagram Users",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               ]
                                  },
                                @{@"title" : @"Missed Connections",
                                  @"image" : @"missedConnectionsIconImage",
                                  @"items" : @[@{@"title" : @"Users I Engage, But Don’t Follow",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Admirers",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               ]
                                  },
                                @{@"title" : @"History",
                                  @"image" : @"historyIconImage",
                                  @"items" : @[@{@"title" : @"My Earliest Followers",
                                                 @"image" : @"lockIconImage"
                                                 },
                                               @{@"title" : @"Users I’ve Unfollowed",
                                                 @"image" : @"lockIconImage"
                                                 },
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
                    index ++;
                    
                }
                {
                    SeparatorCellSource *cellSource = [SeparatorCellSource new];
                    cellSource.backgroundColor = [AppUtils appBackgroundColor];
                    [section addObject:cellSource];
                    
                }

            }
        }
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
}





-(void)itemSelected:(UIButton*)sender
{

    [self performSegueWithIdentifier:segue_showUserAudienceTops sender:@(sender.tag)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    
    
    if ([segue.identifier isEqualToString:segue_showUserAudienceTops]) {
        
        UserAudienceTopsViewController* tops = segue.destinationViewController;
        tops.selectedItem = [sender integerValue];
        
    }
    
    
}


@end
