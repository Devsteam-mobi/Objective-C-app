//
//  HTTPClient.h
//  InstaTracker
//
//  Created by Devsteam.Mobi iMac on 10/24/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "AFHTTPSessionManager.h"


@interface HTTPClient : AFHTTPSessionManager




+ (HTTPClient *)sharedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (BOOL)connected;

@end
