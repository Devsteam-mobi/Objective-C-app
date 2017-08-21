//
//  UserEngagementTopsViewController.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import "BaseTableViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface UserEngagementTopsViewController : BaseTableViewController

@property (nonatomic,assign) NSInteger selectedItem;
@property (nonatomic,retain) NSString* selectedItemId;
@property (strong, nonatomic) CLLocation *userLocation;
@end
