//
//  MainId.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 12/13/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <Realm/Realm.h>


@interface MainId : RLMObject
@property NSString *mainId;
+(NSString*)mainId;
+(void)setMainId:(NSString*)mainId;
@end
