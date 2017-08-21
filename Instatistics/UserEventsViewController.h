//
//  UserEventsViewController.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import "BaseTableViewController.h"




@interface UserEventsViewController : BaseTableViewController
@property (nonatomic,assign) UserEventType userEventType;
@property (nonatomic,retain) NSString* selectedItemId;
@end
