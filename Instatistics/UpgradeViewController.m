//
//  UpgradeViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UpgradeViewController.h"
#import "CloseCrossButtonCell.h"
#import "ImageViewCell.h"
#import "FolllowerPorCell.h"
#import "TabBarCell.h"
#import "BuyItemsCell.h"
#import "AppConstants.h"
#import "PageControllCell.h"


@interface UpgradeViewController ()

@end

@implementation UpgradeViewController






-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    [self buildInterface];
}




-(void)buildInterface
{
    
    
    
    NSMutableArray *section = [NSMutableArray new];
   
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 5;
        [section addObject:cellSource];
    }
    {
        CloseCrossButtonCellSource *cellSource = [CloseCrossButtonCellSource new];
        cellSource.selector = @selector(closeView:);
        [section addObject:cellSource];
        
    }
    
    {
        PageControllCellSource *cellSource = [PageControllCellSource new];
        cellSource.target = self;
        cellSource.selectedTag = _selectedTag;
        [section addObject:cellSource];
    }
    
    
    float height = 0;
    
    for (IDDCellSource * cellSource in section) {
        height += cellSource.staticHeightForCell;
    }
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = ([AppUtils viewHeight] - self.tableView.frame.origin.y) - height - 100.5 - ([AppUtils isIphoneVersion:4] ? 0 : 40);
        [section addObject:cellSource];
    }
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = [AppUtils isIphoneVersion:4] ? 0 : 40;
        [section addObject:cellSource];
    }
    {
        
        TabBarCellSource *cellSource = [TabBarCellSource new];
        cellSource.selector = @selector(selectTag:);
        cellSource.target = self;
        cellSource.selectedTag = _selectedTag;
        [section addObject:cellSource];
    }
    
    
    
    
    {
        BuyItemsCellSource *cellSource = [BuyItemsCellSource new];
        cellSource.title = @"1 Month for $0.99";
        cellSource.leesString = @"";
        cellSource.selector = @selector(buyItem:);
        cellSource.cellTag = 0;
        cellSource.target = self;
        
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        cellSource.backgroundColor = [AppUtils topMenuTitleColor];
        [section addObject:cellSource];
    }
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
}



-(IBAction)selectTag:(UIButton*)sender
{
    _selectedTag = sender.tag;
    [self buildInterface];
}

-(void)closeView:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}


@end
