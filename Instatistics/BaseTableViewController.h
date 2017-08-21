//
//  BaseTableViewController.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/5/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "BaseViewController.h"
#import <ImoDynamicTableView/ImoDynamicTableView.h>
#import "SeparatorCell.h"
#import "SpaceCell.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@interface BaseTableViewController : BaseViewController

@property (nonatomic, weak) IBOutlet ImoDynamicTableView * tableView;
@property (nonatomic, strong) UIRefreshControl *topRefreshControl;
@property (nonatomic, strong) UIRefreshControl *bottomRefreshControl;
@property (nonatomic, strong) IGPagination *pagination;
-(void)hideKeyboard;
@end
