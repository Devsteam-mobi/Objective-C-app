//
//  Storage.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/26/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "Storage.h"
#import "AppUtils.h"
#import "StringEncrypt.h"

@implementation Storage


#define API_KEY @"DA8B9B217DE9E123"




+(void)setUserLogin:(NSString*)isActive
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:isActive forKey:@"userLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getUserLogin
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults stringForKey:@"userLogin"];
}

+(void)setPriority:(NSString*)priority
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:[StringEncrypt encryptString:priority withKey:API_KEY] forKey:@"priority"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getPriority
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    if ([AppUtils isValidObject:[userdefaults stringForKey:@"priority"]]) {
        return [StringEncrypt decryptString:[userdefaults stringForKey:@"priority"] withKey:API_KEY];
    }
    
    return nil;
}

+(void)setWasErrorOnSubscription:(BOOL)priority
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setBool:priority forKey:@"wasErrorOnSubscription"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)wasErrorOnSubscription
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults boolForKey:@"wasErrorOnSubscription"];
}


+(void)setExpirationDate:(NSDate*)expirationDate
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:expirationDate forKey:@"subscribtionWillExpireAt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSDate *)getExpirationDate
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults objectForKey:@"subscribtionWillExpireAt"];
}



@end
