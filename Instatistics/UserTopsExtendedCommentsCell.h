//
//  UserTopsExtendedCommentsCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "IGComment.h"
#import "AppConstants.h"


@interface UserTopsExtendedCommentsCellSource : IDDCellSource
@property (nonatomic,assign) BOOL liked;
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) RLMResults * comments;



@end

@interface UserTopsExtendedCommentsCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (weak, nonatomic) IBOutlet UIImageView *separatorImage;
@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

- (void)setUpWithSource:(UserTopsExtendedCommentsCellSource*)source;
@end

