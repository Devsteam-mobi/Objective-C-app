//
//  StringEncrypt.m
//  VIEWS
//
//  Created by Devsteam.mobi on 6/28/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "StringEncrypt.h"
#import "CoderEncrypt.h"
@implementation StringEncrypt
+ (NSString *) encryptString:(NSString*)plaintext withKey:(NSString*)key {
    NSData *data = [[plaintext dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:key];
    return [data base64EncodedStringWithOptions:kNilOptions];
}

+ (NSString *) decryptString:(NSString *)ciphertext withKey:(NSString*)key {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:ciphertext options:kNilOptions];
    return [[NSString alloc] initWithData:[data AES128DecryptWithKey:key] encoding:NSUTF8StringEncoding];
}
@end
