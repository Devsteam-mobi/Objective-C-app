//
//  DataLoader.h
//  InstaTracker
//
//  Created by Devsteam.Mobi iMac on 10/24/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>





typedef void (^SuccessRH) (id responseObject);
typedef void (^FailRH) (NSError *error);




@interface DataLoader : NSObject



+(void)request:(NSString*)urlString parameters:(NSDictionary*)parameters success:(SuccessRH)success fail:(FailRH)fail;


@end
