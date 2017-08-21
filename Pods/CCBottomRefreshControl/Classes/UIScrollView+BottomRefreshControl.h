//
//  UITableView+BottomRefreshControl.h
//  BottomRefreshControl
//
//  Created by Devsteam.mobi on 14.01.14.
//  Copyright (c) 2014 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (BottomRefreshControl)

@property (nullable, nonatomic) UIRefreshControl *bottomRefreshControl;

@end


@interface UIRefreshControl (BottomRefreshControl)

@property (nonatomic) CGFloat triggerVerticalOffset;

@end
