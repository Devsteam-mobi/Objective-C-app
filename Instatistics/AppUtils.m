//
//  AppUtils.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/6/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "AppUtils.h"
#import "AppConstants.h"

@implementation AppUtils




+(BOOL) isEmailValid:(NSString *)checkString
{
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
}


+(void)setApplicationAppearence
{
    
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back-button-image"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back-button-image"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],                                                                                                                      NSFontAttributeName: [UIFont fontWithName:_lato_font_black size:14],
                                                           }];
    
    
    
}


+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


+(BOOL)showLockedItems
{
    if ([AppUtils isValidObject:[Storage getExpirationDate]] == NO) {
        return YES;
    }
    
    if ([[NSDate date] compare:[Storage getExpirationDate]] == NSOrderedDescending) {
        
        return YES;
    }
    
    return NO;
}

+(BOOL)isValidObject:(id)object
{
    return (object != nil && [object isKindOfClass:[NSNull class]] == NO);

}

+(BOOL)isValidString:(NSString*)object
{
    
    if ([AppUtils isValidObject:object] && [object isKindOfClass:[NSString class]])
    {
        return  YES;
    }
    
    return NO;
    
}


+(void)openUrl:(NSString*)urlString
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

}

+(NSString*)validateString:(NSString*)object
{
    
    if ([AppUtils isValidObject:object])
    {
        return  object;
    }
    
    return @"";
    
}


+(UIColor*)appBackgroundColor
{
    
    return [UIColor colorWithRed:17.0/255.0
                           green:23.0/255.0
                            blue:33.0/255.0
                           alpha:255.0/255.0];
    
}


+(UIColor*)inputFieldTextColor
{
    return [UIColor colorWithRed:229.0/255.0
                           green:227.0/255.0
                            blue:220.0/255.0
                           alpha:255.0/255.0];
}


+(UIColor*)placeholdersColor
{
    return [UIColor colorWithRed:91.0/255.0
                           green:102.0/255.0
                            blue:121.0/255.0
                           alpha:255.0/255.0];
}


+(UIColor*)separatorsColor
{
    return [UIColor colorWithRed:149.0/255.0
                           green:152.0/255.0
                            blue:154.0/255.0
                           alpha:25.0/255.0];

}

+(UIColor*)topMenuTitleColor
{
    return [UIColor colorWithRed:53.0/255.0
                           green:64.0/255.0
                            blue:82.0/255.0
                           alpha:255.0/255.0];
    
}

+(UIColor*)topMenuBackgroundColor
{
    return [UIColor colorWithRed:230.0/255.0
                           green:233.0/255.0
                            blue:240.0/255.0
                           alpha:255.0/255.0];
    
}


+(UIColor*)greenBlueColor
{
    return [UIColor colorWithRed:47.0/255.0
                           green:230.0/255.0
                            blue:222.0/255.0
                           alpha:255.0/255.0];
    
}

+(UIColor*)collectionViewItemsColor
{
    return [UIColor colorWithRed:39.0/255.0
                           green:49.0/255.0
                            blue:65.0/255.0
                           alpha:255.0/255.0];
    
}

+(UIColor*)lightBlackColor
{
    return [UIColor colorWithRed:26.0/255.0
                           green:34.0/255.0
                            blue:47.0/255.0
                           alpha:255.0/255.0];
    
}

+(UIColor*)collectionViewItemsTitleColor
{
    return [UIColor colorWithRed:110.0/255.0
                           green:119.0/255.0
                            blue:136.0/255.0
                           alpha:255.0/255.0];
}

+(UIColor*)blueBackgroundColor
{
    return [UIColor colorWithRed:21.0/255.0
                           green:164.0/255.0
                            blue:250.0/255.0
                           alpha:255.0/255.0];
}

+(UIColor*)commentsTextColor
{
    return [UIColor colorWithRed:36.0/255.0
                           green:36.0/255.0
                            blue:36.0/255.0
                           alpha:255.0/255.0];
}

+(UIColor*)grayItemTextColor
{
    return [UIColor colorWithRed:160.0/255.0
                           green:172.0/255.0
                            blue:191.0/255.0
                           alpha:255.0/255.0];
}


+(UIColor*)unlockWithTextColor
{
    return [UIColor colorWithRed:168.0/255.0
                           green:168.0/255.0
                            blue:168.0/255.0
                           alpha:255.0/255.0];
}

+(UIColor*)followGreenColor
{
    return [UIColor colorWithRed:3.0/255.0
                           green:160.0/255.0
                            blue:63.0/255.0
                           alpha:255.0/255.0];
}


+(UIColor*)userActionColor
{
    return [UIColor colorWithRed:106.0/255.0
                           green:106.0/255.0
                            blue:106.0/255.0
                           alpha:255.0/255.0];
}


+(CGFloat)viewHeight
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    return screenHeight;
}

+(NSString*)minimizedCountString:(NSUInteger)value
{
    float count = value;
    NSString * measure = @"";
    
    if (count >= 1000000000 ) {
        count /= 1000000000;
        measure = @" G";
    }
    
    else if (count >= 1000000 ) {
        count /= 1000000;
        measure = @" M";
    }
    
    else if (count >= 1000 ) {
        count /= 1000;
        measure = @" K";
    }
    
    return [[NSString stringWithFormat:@"%.1f%@", count,measure] stringByReplacingOccurrencesOfString:@".0" withString:@""];
}

+(CGFloat)widthForStatisticsMenuItem:(HorisontalMenuItem*)item
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAXFLOAT, MAXFLOAT)];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:_lato_font_regular size:17];
    
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
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_lato_font_black size:9] range:[fullString rangeOfString:titleString]];
    
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(4) range:[fullString rangeOfString:newCountString]];
    
    
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = item.arrowImage;
    CGFloat offsetY = 3.5f;
    textAttachment.bounds = CGRectMake(0, offsetY, textAttachment.image.size.width, textAttachment.image.size.height);
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString  insertAttributedString:attrStringWithImage atIndex:totalString.length + 2];
    
    
    label.attributedText = attributedString;
    [label sizeToFit];
    return label.frame.size.width + 16;
}

+(BOOL)isIphoneVersion:(int)iPhoneVersion
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480 && iPhoneVersion == 4)
        {
            return YES;
        }
        if(result.height == 568 && iPhoneVersion == 5)
        {
            return YES;
        }
    }
    return NO;
}
@end
