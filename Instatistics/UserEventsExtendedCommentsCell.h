//
//  UserEventsExtendedCommentsCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "IGComment.h"
#import "AppConstants.h"


@interface UserEventsExtendedCommentsCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) IGComment * comment;


@end

@interface UserEventsExtendedCommentsCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIImageView *separatorImage;
@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

- (void)setUpWithSource:(UserEventsExtendedCommentsCellSource*)source;
@end

