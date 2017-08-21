//
//  UserEventsCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "IGMedia.h"
#import "AppConstants.h"


@interface UserEventsCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) IGUser * user;
@property (nonatomic,assign) NSUInteger eventsCount;
@property (nonatomic,assign) UserEventType userEventType;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL showDistance;
@property (nonatomic,assign) SEL profileSelector;
@end

@interface UserEventsCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *separatorImage;
@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;

- (void)setUpWithSource:(UserEventsCellSource*)source;
@end

