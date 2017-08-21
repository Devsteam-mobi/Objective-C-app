//
//  PhotoItemCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "PhotoItemCell.h"
#import "AppUtils.h"
#import "AppConstants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "IGMedia.h"

@implementation PhotoItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setupWithItem:(IGMedia*)media
{
    self.backgroundColor = [AppUtils collectionViewItemsColor];
    _userImage.image = nil;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:media.image.standard_resolution]];
    
}



@end
