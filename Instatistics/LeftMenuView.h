//
//  LeftMenuView.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 12/2/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImoDynamicTableView/ImoDynamicTableView.h>


@interface LeftMenuView : UIVisualEffectView <ImoDynamicTableViewDelegate>
@property (nonatomic, weak) IBOutlet ImoDynamicTableView * tableView;
@property (nonatomic, strong)  id target;

-(void)buildInterface;
@end
