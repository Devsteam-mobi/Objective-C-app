//
//  StringEncrypt.h
//  VIEWS
//
//  Created by Devsteam.mobi on 6/28/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringEncrypt : NSObject
+ (NSString *) encryptString:(NSString*)plaintext withKey:(NSString*)key;
+ (NSString *) decryptString:(NSString *)ciphertext withKey:(NSString*)key;
@end
