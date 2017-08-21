//
//  FollowMenuCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerticalMenuItem.h"



@interface FollowMenuCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) id target;
@property (nonatomic,assign) NSInteger index;


-(void)setupWithItem:(VerticalMenuItem*)item;
@end
