//
//  IGUser.h
//  Instamap
//
//  Created by Devsteam.mobi on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface IGUser : RLMObject<NSCoding> {
    
}
@property (nonatomic, retain) NSString * full_name;
@property (nonatomic, retain) NSNumber<RLMInt> * media_count;
@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) NSNumber<RLMInt> * followed_by_count;
@property (nonatomic, retain) NSString * profile_picture;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSNumber<RLMInt> * follows_count;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * password;
+(IGUser*)userWithDictionary:(NSDictionary*)dict;
@end

RLM_ARRAY_TYPE(IGUser)
