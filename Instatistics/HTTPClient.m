//
//  HTTPClient.m
//  InstaTracker
//
//  Created by Devsteam.Mobi iMac on 10/24/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//


#import "HTTPClient.h"
#import "AFNetworking.h"
#import "DataLoader.h"
#import "AppUtils.h"


@implementation HTTPClient

+ (HTTPClient *)sharedHTTPClient
{
    static HTTPClient *_sharedHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[HTTPClient new] init];
        
      
       
    });
    
    return _sharedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
   
    if (self) {
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [self.requestSerializer setTimeoutInterval:120.0];
    }
    
    return self;
}

- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
