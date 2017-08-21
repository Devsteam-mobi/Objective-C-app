//
//  AppUtils.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/6/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Storage.h"
#import "HorisontalMenuItem.h"

@interface AppUtils : NSObject
+(BOOL) isEmailValid:(NSString *)checkString;


+(UIColor*)appBackgroundColor;
+(UIColor*)inputFieldTextColor;
+(UIColor*)placeholdersColor;
+(UIColor*)separatorsColor;
+(UIColor*)greenBlueColor;
+(UIColor*)topMenuTitleColor;
+(UIColor*)topMenuBackgroundColor;
+(UIColor*)collectionViewItemsColor;
+(UIColor*)lightBlackColor;
+(UIColor*)collectionViewItemsTitleColor;
+(UIColor*)blueBackgroundColor;
+(UIColor*)commentsTextColor;
+(UIColor*)grayItemTextColor;
+(UIColor*)unlockWithTextColor;
+(UIColor*)followGreenColor;
+(UIColor*)userActionColor;


+(CGFloat)viewHeight;
+(NSString*)minimizedCountString:(NSUInteger)value;
+(CGFloat)widthForStatisticsMenuItem:(HorisontalMenuItem*)item;
+(void)setApplicationAppearence;
+ (UIViewController*)topViewController;
+(BOOL)showLockedItems;

+(BOOL)isValidObject:(id)object;
+(BOOL)isValidString:(NSString*)object;
+(NSString*)validateString:(NSString*)object;
+(BOOL)isIphoneVersion:(int)iPhoneVersion;
+(void)openUrl:(NSString*)urlString;

@end
