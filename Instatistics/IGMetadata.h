//
//  IGMetadata.h
//  Instamap
//
//  Created by Devsteam.mobi on 3/23/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IGMetadata : NSObject {
    
}
@property (nonatomic,retain) NSNumber* code;
@property (nonatomic,retain) NSString* error_message;
@property (nonatomic,retain) NSString* error_type;
+(IGMetadata*)metadataWithDictionary:(NSDictionary*)dict;
@end
