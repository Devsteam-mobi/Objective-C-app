//
//  HorisontalMenuCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorisontalMenuItem.h"



@interface HorisontalMenuCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
-(void)setupWithItem:(HorisontalMenuItem*)item;
@end
