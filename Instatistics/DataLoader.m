//
//  DataLoader.m
//  InstaTracker
//
//  Created by Devsteam.Mobi iMac on 10/24/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "DataLoader.h"
#import "StringEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import "HTTPClient.h"
#import "AppUtils.h"


@implementation DataLoader






+(void)request:(NSString*)urlString parameters:(NSDictionary*)parameters success:(SuccessRH)success fail:(FailRH)fail
{
    
    [[HTTPClient sharedHTTPClient] GET:urlString parameters:parameters success:^(NSURLSessionTask *task, NSDictionary* responseObject) {
        
        
        NSString *errorString = [AppUtils validateString:responseObject[@"error"]];
        
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:@"Instatistics" code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
            fail(error);
        }
        else
        {
            success(responseObject[@"response"]);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [DataLoader alertUserForError:error];
        fail(error);
    }];
}



+(void)alertUserForError:(NSError*)error
{
    
    UIApplication * application = [UIApplication sharedApplication];
    if ( application.applicationState == UIApplicationStateInactive
        || application.applicationState == UIApplicationStateBackground  ) {
        
        return;
        
    }
    
    NSLog(@"\n\n\n%@\n\n\n",error);
    
    if ([error.domain isEqualToString:@"Instatistics"]) {
        NSString *messageString = error.userInfo[@"message"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Instatistics" message:messageString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                   }];
        
        [alert addAction:okButton];
        [[AppUtils topViewController] presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        NSString *messageString = error.localizedDescription;
        if ([[HTTPClient sharedHTTPClient] connected] == NO || [messageString isEqualToString:@"The network connection was lost."]) {
            
            return;
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Server error!" message:messageString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                   }];
        
        [alert addAction:okButton];
        [[AppUtils topViewController] presentViewController:alert animated:YES completion:nil];
    }
    
}

@end
