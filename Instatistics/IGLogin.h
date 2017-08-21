//
//  IGLogin.h
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IGLogin : NSObject
@property (nonatomic, retain) NSString * full_name;
@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) NSString * profile_pic_url;
@property (nonatomic, retain) NSString * profile_pic_id;
@property (nonatomic, retain) NSString * username;
- (instancetype )initWithDictionary:(NSDictionary*)dict;

@end


