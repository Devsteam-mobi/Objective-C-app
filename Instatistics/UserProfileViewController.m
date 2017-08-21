//
//  UserProfileViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileHeaderCell.h"
#import "UserInfoCell.h"
#import "UserPhotosCell.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [_followerUser.username uppercaseString];
   
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
    [self getUser];
    
 
}

-(void)getUser
{
    [[InstagramAPI sharedInstance] getUser:_followerUser.Id comp:^(IGUser *user) {
        _followerUser = user;
        [self buildInterface];
    } failure:^(NSError *error) {
        
    }];
}


-(void)buildInterface
{

    NSMutableArray *section = [NSMutableArray new];
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        cellSource.staticHeightForCell = 1.0f;
        cellSource.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.1f];
        [section addObject:cellSource];
    }
    {
        UserProfileHeaderCellSource *cellSource = [UserProfileHeaderCellSource new];
        cellSource.user = _followerUser;
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        cellSource.staticHeightForCell = 1.0f;
        cellSource.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.1f];
        [section addObject:cellSource];
    }
    {
        UserInfoCellSource *cellSource = [UserInfoCellSource new];
        cellSource.user = _followerUser;
        [section addObject:cellSource];
    }
    
    
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        cellSource.staticHeightForCell = 1.0f;
        cellSource.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.1f];
        [section addObject:cellSource];
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    float height = 0;
    
    for (IDDCellSource * cellSource in section) {
        height += cellSource.staticHeightForCell;
    }
    
    {
        UserPhotosCellSource *cellSource = [UserPhotosCellSource new];
        cellSource.staticHeightForCell = ([AppUtils viewHeight] - self.tableView.frame.origin.y - 64) - height;
        cellSource.target = self;
        cellSource.user = _followerUser;
        [section addObject:cellSource];
    }
    
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








#pragma mark - Navigation


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [super prepareForSegue:segue sender:sender];
//    
//   
//    
//}


@end
