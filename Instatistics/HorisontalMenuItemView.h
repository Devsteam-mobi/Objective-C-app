//
//  HorisontalMenuItemView.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 12/9/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorisontalMenuItem.h"

@interface HorisontalMenuItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
-(CGFloat)setupWithItem:(HorisontalMenuItem*)item;

@end
