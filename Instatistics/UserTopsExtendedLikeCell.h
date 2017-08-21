//
//  UserTopsExtendedLikeCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "IGMedia.h"
#import "AppConstants.h"


@interface UserTopsExtendedLikeCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) IGLiker * liker;
@end

@interface UserTopsExtendedLikeCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (weak, nonatomic) IBOutlet UIImageView *separatorImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

- (void)setUpWithSource:(UserTopsExtendedLikeCellSource*)source;
@end

