//
//  LeftMenuItemCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "LeftMenuItemCell.h"
#import "AppUtils.h"
#import "UserStatisticsViewController.h"
@implementation LeftMenuItemCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"LeftMenuItemCell";
      self.backgroundColor = [AppUtils separatorsColor];
      self.staticHeightForCell = 60.0f;
      self.titleColor = [UIColor whiteColor];
  }
  return self;
}

@end


@implementation LeftMenuItemCell

- (void)setUpWithSource:(LeftMenuItemCellSource*)source
{
    
    _userImage.image = [UIImage imageNamed:source.itemInfo[@"image"]];
    _nameLabel.textColor = source.titleColor;
    
    _backView.backgroundColor = source.isSelected ? [AppUtils collectionViewItemsColor] : [UIColor clearColor];
    self.backgroundColor = source.isSelected ? [AppUtils blueBackgroundColor] : [UIColor clearColor];
    
    NSString * titleString = [source.itemInfo[@"title"] uppercaseString];
    NSString * subTitleString = source.itemInfo[@"subtitle"];
    NSString *fullString = titleString;
    if ([AppUtils isValidObject:subTitleString]) {
        fullString = [fullString stringByAppendingFormat:@"\n%@",subTitleString];
    }

    _nameLabel.font = [UIFont fontWithName:_nameLabel.font.fontName size:[source.itemInfo[@"itemTag"] integerValue] == 4 ? 12 : 16];
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString new] initWithString:fullString];
    
    if ([AppUtils isValidObject:subTitleString])
    {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[AppUtils blueBackgroundColor] range:[fullString rangeOfString:subTitleString]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_black size:11] range:[fullString rangeOfString:subTitleString]];
    }
//    UserStatisticsViewController * statistics = (UserStatisticsViewController*)source.target;
    
    _nameLabel.attributedText = attrStr;
    
    
    _selectButton.tag = [source.itemInfo[@"itemTag"] integerValue];
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
}

@end




