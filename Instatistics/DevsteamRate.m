//
//  DevsteamRate.m
//  Engage
//
//  Created by Devsteam.mobi on 1/19/17.
//  Copyright © 2016 Devsteam.Mobi. All rights reserved.
//
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "DevsteamRate.h"
#import "DataLoader.h"
#define UD     [NSUserDefaults standardUserDefaults]
#define likeNumber @"likeMWrate"
#define daysNumber @"daysMWrate"
#define usesNumber @"usesMWrate"
#define showed @"showMWrate"


#define likeNumberSuper @"likeMWsuper"
#define usesNumberSuper @"usesMWsuper"

#define purchasedA @"purchased"
static DevsteamRate *sharedInstance;
@implementation DevsteamRate
+(DevsteamRate*) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DevsteamRate alloc] init];
    });
    return sharedInstance;
}
-(void)purchased
{
    [UD setBool:true forKey:purchasedA];
}
-(void)addUses
{
    int likes = [[UD objectForKey:usesNumber] intValue] + 1;
    [UD setObject:[NSString stringWithFormat:@"%d",likes] forKey:usesNumber];
    
    likes = [[UD objectForKey:usesNumberSuper] intValue] + 1;
    [UD setObject:[NSString stringWithFormat:@"%d",likes] forKey:usesNumberSuper];
}
-(void)increaseLikeNumber
{
    int likes = [[UD objectForKey:likeNumber] intValue] + 1;
    [UD setObject:[NSString stringWithFormat:@"%d",likes] forKey:likeNumber];
    
    likes = [[UD objectForKey:likeNumberSuper] intValue] + 1;
    [UD setObject:[NSString stringWithFormat:@"%d",likes] forKey:likeNumberSuper];
}
-(void)firstUses
{
    if(![UD objectForKey:daysNumber]) {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:daysNumber];
        
        [UD setBool:@"0" forKey:usesNumberSuper];
           [UD setBool:@"0" forKey:usesNumber];
        
        [UD setBool:@"0" forKey:likeNumberSuper];
        [UD setBool:@"0" forKey:likeNumber];
        
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(BOOL)canShowSuperOffer
{
    int uses = [[UD objectForKey:usesNumberSuper] intValue];
    int likes = [[UD objectForKey:likeNumberSuper] intValue];
 
    BOOL can = false;
    if([DevsteamRate sharedInstance].SuperType == 0)
    {
        can = true;
    }
    if([DevsteamRate sharedInstance].SuperType == 1)
    {
       if([UD boolForKey:purchasedA])
       {
           can = true;
       }
    }
    if([DevsteamRate sharedInstance].SuperType == 1)
    {
        if(![UD boolForKey:purchasedA])
        {
            can = false;
        }
    }
    
 
        if(([DevsteamRate sharedInstance].SuperUsesUntilPrompt < uses || [DevsteamRate sharedInstance].SuperLikesUntilPromt < likes) & can)
        {
            [UD setObject:@"0" forKey:usesNumberSuper];
            [UD setObject:@"0" forKey:likeNumberSuper];
            
            return true;
        } else {
            return false;
        }
        
    
  
}
-(BOOL)canShow
{
    int uses = [[UD objectForKey:usesNumber] intValue];
    int likes = [[UD objectForKey:likeNumber] intValue];
    BOOL showedV = [[UD objectForKey:showed] boolValue];
    
  NSTimeInterval days = [[NSDate date] timeIntervalSinceDate:[UD objectForKey:daysNumber]];
    
    if(showedV)
    {
        return false;
    } else {
    if([DevsteamRate sharedInstance].usesUntilPrompt < uses || [DevsteamRate sharedInstance].likesUntilPromt < likes || [DevsteamRate sharedInstance].daysUntilPromt*86400 < days)
    {
        [UD setBool:true forKey:showed];
        return true;
    } else {
        return false;
    }
    
    }
}
-(void)rateURL
{
   NSString*appStoreCountry = [(NSLocale *)[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    if ([appStoreCountry isEqualToString:@"150"])
    {
        appStoreCountry = @"eu";
    }
    else if (appStoreCountry || [[appStoreCountry stringByReplacingOccurrencesOfString:@"[A-Za-z]{2}" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, 2)] length])
    {
    appStoreCountry = @"us";
    }

        [DataLoader request:[NSString stringWithFormat:@"https://itunes.apple.com/%@/lookup?bundleId=%@", appStoreCountry,  [[NSBundle mainBundle] bundleIdentifier]] parameters:@{} success:^(NSDictionary* responseObject) {
            NSString*rateID = responseObject[@"trackId"];
            _rateURLLink =  [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", rateID]];
        } fail:^(NSError *error) {
            
        }];

   
    

}
-(void)prepareIrate
{
 //   ([[NSDate date] timeIntervalSinceDate:self.firstUsed] < self.daysUntilPrompt * SECONDS_IN_A_DAY)

    [self rateURL];
    
    
    
    
    [self addUses];
    [self firstUses];
    [self serverRequests];
    

    
    //Prepare for show it
}

-(void)serverRequests
{
    
    [DataLoader request:@"http://ontrackmobilellc.com/engagemultilang/irate.php" parameters:@{} success:^(NSArray* responseObject1) {
        NSArray*response = responseObject1;
        
        
        [DevsteamRate sharedInstance].daysUntilPromt = [response[0][@"value"] intValue];
        [DevsteamRate sharedInstance].likesUntilPromt =  [response[2][@"value"] intValue];
        [DevsteamRate sharedInstance].usesUntilPrompt = [response[1][@"value"] intValue];
        
        
        [DevsteamRate sharedInstance].SuperLikesUntilPromt = [response[4][@"value"] intValue];
        
        [DevsteamRate sharedInstance].SuperUsesUntilPrompt = [response[5][@"value"] intValue];
        [DevsteamRate sharedInstance].SuperType = [response[6][@"value"] intValue];
        
        [DevsteamRate sharedInstance].offer_link = [NSURL URLWithString:response[8][@"value"]];
        
        [DevsteamRate sharedInstance].offerCount = [response[9][@"value"] integerValue];
        
        
        [DataLoader request:@"http://ip-api.com/json" parameters:@{} success:^(NSDictionary* responseObject2) {
            
            
            NSLog(@"JSON - %@", responseObject2[@"countryCode"]);
            
            CTCarrier *carrier = [[CTTelephonyNetworkInfo new] subscriberCellularProvider];
            NSString *countryCode = carrier.isoCountryCode;
            NSLog(@"countryCode: %@", [countryCode uppercaseString]);
            
            NSString*countryBySim = [NSString stringWithFormat:@"%@", [countryCode uppercaseString]];
            
            if( [[responseObject2[@"countryCode"] uppercaseString] isEqualToString:countryBySim])
            {
                _native = true;
            } else{
                _native = false;
            }
            
            
            
            //GET TEXT FOR ALERT
            [DataLoader request:@"http://ontrackmobilellc.com/engagemultilang/irate.php?mode=lang" parameters:@{@"lang":[responseObject2[@"countryCode"] uppercaseString]} success:^(id responseObject3) {
                if(_native) {
                    _showAlertText = responseObject3[@"response"][@"text2"];
                } else {
                    _showAlertText = responseObject3[@"response"][@"text1"];
                }

            } fail:^(NSError *error) {

            }];
            
            
        } fail:^(NSError *error) {
            
        }] ;       //Check native non native
        
        
    } fail:^(NSError *error) {
        
    }];
   
    }


-(BOOL) lastVersion{
        NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString* appID = infoDictionary[@"CFBundleIdentifier"];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
        NSData* data = [NSData dataWithContentsOfURL:url];
    
    if(data != nil) {
        NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([lookup[@"resultCount"] integerValue] == 1){
            NSString* appStoreVersion = lookup[@"results"][0][@"version"];
            NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
            if (![appStoreVersion isEqualToString:currentVersion]){
                
                _curentVersion = currentVersion;
                _lastVersionString = appStoreVersion;
                
                NSLog(@"Need to update [%@ != %@]", appStoreVersion, currentVersion);
                return NO;
            }
        }
        
    }
    return TRUE;
    }

@end
