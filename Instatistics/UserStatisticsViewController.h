//
//  UserStatisticsViewController.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "BaseTableViewController.h"


@interface UserStatisticsViewController : BaseTableViewController
@property (nonatomic,strong) RLMResults * usersToSwitch;
@property (nonatomic,assign) BOOL isVisible;
-(void)drawMenu;
-(void)selectUser:(IGUser*)user;
-(void)logout:(MainUser*)mainUser;

@end
