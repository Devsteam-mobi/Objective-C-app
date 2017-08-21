//
//  DevsteamRate.h
//  Engage
//
//  Created by Devsteam.mobi on 1/19/17.
//  Copyright © 2016 Devsteam.Mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DevsteamRate : NSObject
+(DevsteamRate*) sharedInstance;
-(BOOL)lastVersion;
-(void)prepareIrate;
-(void)increaseLikeNumber;
-(void)rateURL;
-(BOOL)canShow;
-(BOOL)canShowSuperOffer;
-(void)purchased;

@property BOOL native;
@property (nonatomic, assign) NSString* curentVersion;
@property (nonatomic, assign) NSString* showAlertText;
@property (nonatomic, assign) NSString* lastVersionString;
@property (nonatomic, strong) NSURL*rateURLLink;
@property (nonatomic, assign) NSUInteger usesUntilPrompt;
@property (nonatomic, assign) NSUInteger daysUntilPromt;
@property (nonatomic, assign) NSUInteger likesUntilPromt;

@property (nonatomic, strong) NSURL*offer_link;
@property (nonatomic, assign) NSUInteger offerCount;


@property (nonatomic, assign) NSUInteger SuperUsesUntilPrompt;
@property (nonatomic, assign) NSUInteger SuperLikesUntilPromt;
@property (nonatomic, assign) NSUInteger SuperType;
@end
