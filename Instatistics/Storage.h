//
//  Storage.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/26/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Storage : NSObject

+(void)setUserLogin:(NSString*)isActive;
+(NSString*)getUserLogin;
+(void)setPriority:(NSString*)isActive;
+(NSString*)getPriority;
+(void)setWasErrorOnSubscription:(BOOL)priority;
+(BOOL)wasErrorOnSubscription;
+(void)setExpirationDate:(NSDate*)expirationDate;
+(NSDate *)getExpirationDate;
@end
