//
//  HorisontalMenuItemView.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 12/9/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "HorisontalMenuItemView.h"
#import "AppUtils.h"
#import "AppConstants.h"

@implementation HorisontalMenuItemView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


-(CGFloat)setupWithItem:(HorisontalMenuItem*)item
{
    
    self.backgroundColor = [AppUtils collectionViewItemsColor];
    
    
    NSString * totalString = [@"" stringByAppendingFormat:@"%.0f",item.currentCount];
    NSString * newCountString = [NSString stringWithFormat:@" %.0f",fabs(item.difference)];
    if (item.isFloat) {
        totalString = [@"" stringByAppendingFormat:@"%.2f",item.currentCount];
        newCountString = [NSString stringWithFormat:@" %.2f",fabs(item.difference)];
    }

    NSString * titleString = item.title;
    
    
    NSString * fullString = [NSString stringWithFormat:@"%@  %@\n%@", totalString, newCountString,titleString];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString new] initWithString:fullString];
    
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[AppUtils collectionViewItemsTitleColor] range:[fullString rangeOfString:titleString]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[AppUtils collectionViewItemsTitleColor] range:[fullString rangeOfString:newCountString]];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_bold size:10] range:[fullString rangeOfString:newCountString]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_bold size:9] range:[fullString rangeOfString:titleString]];
    
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(4) range:[fullString rangeOfString:newCountString]];
    
    
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = item.arrowImage;
    CGFloat offsetY = 3.5f;
    textAttachment.bounds = CGRectMake(0, offsetY, textAttachment.image.size.width, textAttachment.image.size.height);
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString  insertAttributedString:attrStringWithImage atIndex:totalString.length + 2];
    
    _titleLabel.attributedText = attributedString;
    [_titleLabel sizeToFit];
    
    return _titleLabel.frame.size.width + 20;
}


@end
