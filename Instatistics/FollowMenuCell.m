//
//  FollowMenuCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "FollowMenuCell.h"
#import "AppUtils.h"
#import "AppConstants.h"

@implementation FollowMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setupWithItem:(VerticalMenuItem*)item
{

    
    self.backgroundColor = [AppUtils collectionViewItemsColor];
    _iconImage.image = item.iconImage;
    
    NSString * titleString = [@"" stringByAppendingFormat:@"%@",item.title];
    NSString * bigCountString = [@"" stringByAppendingFormat:@"%.0f",fabs(item.currentCount)];
    NSString * totalString = item.difference >= 0 ? @"GROWING" : @"DECREASING";
    
    NSString * fullString = [NSString stringWithFormat:@"%@\n%@  \n%@", titleString,bigCountString,totalString];
    if (_index ==  _not_following_me_back || _index == _i_am_not_following_back)
    {
    fullString = [NSString stringWithFormat:@"%@\n%@  ", titleString,bigCountString];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString new] initWithString:fullString];
    
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_bold size:11] range:[fullString rangeOfString:totalString]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_black size:14] range:[fullString rangeOfString:titleString]];

   
    
    if (_index !=  _not_following_me_back || _index != _i_am_not_following_back)
    {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[AppUtils collectionViewItemsTitleColor] range:[fullString rangeOfString:totalString]];
    }
    
    
    if (_index < 3 || _index > 5) {
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = item.arrowImage;
        CGFloat offsetY = 8.0;
        textAttachment.bounds = CGRectMake(0, offsetY, textAttachment.image.size.width, textAttachment.image.size.height);
        NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [attributedString  insertAttributedString:attrStringWithImage atIndex:bigCountString.length + titleString.length+2];
    }
    
    

    _titleLabel.attributedText = attributedString;
    
}

- (IBAction)selectItem:(UIButton*)sender {
    
    if ([AppUtils showLockedItems]) {
        UIViewController * viewController = [AppUtils topViewController];
        [viewController.navigationController performSegueWithIdentifier:segue_showUpgradeView sender:nil];
        return;
    }
    
    [_target performSegueWithIdentifier:segue_showUserEvents sender:@(_index)];
    
    
    
}

@end
