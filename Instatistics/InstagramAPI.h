//
//  InstagramAPI.h
//
//
//  Created by Devsteam.Mobi on 5/24/16.
//  Copyright © 2016 Devsteam.Mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGImage.h"
#import "IGMedia.h"
#import "IGTag.h"
#import "IGSubscription.h"
#import "IGUser.h"
#import "IGPagination.h"
#import "MainUser.h"
#import "IGLogin.h"

@interface InstagramAPI : NSObject
{
    NSString*key;
    NSString*ua;
    NSString*curusr;
    NSString*uuidDevice;
}
@property BOOL review;
+(InstagramAPI*) sharedInstance;
-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password comp:(void (^)(BOOL response))completion failure:(void (^)(NSError *))failure;

-(void)getUser:(NSString*)user comp:(void (^)(IGUser* user))completion failure:(void (^)(NSError *))failure;


-(void)getUserFollowers:(NSString*)userID count:(int)count nextCursor:(NSString*)next comp:(void (^)(NSArray* response, IGPagination *pagination))completion failure:(void (^)(NSError *))failure;

-(void)getUserFollowing:(NSString*)userID count:(int)count  nextCursor:(NSString*)next comp:(void (^)(NSArray* response, IGPagination *pagination))completion failure:(void (^)(NSError *))failure;

-(void)getUserFeed:(NSString*)userid count:(int)count maxId:(NSString*)maxID getComments:(BOOL)getComments comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure;

-(void)getTimeline:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure;

-(void)followUser:(NSString*)user comp:(void (^)(int response))completion;
-(void)unfollowUser:(NSString*)user  comp:(void (^)(int completition))completion;

-(void)getMediaIveLiked:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure;


-(void)getMediaLikes:(NSString*)mediaID maxId:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure;

-(void)getMediaComments:(NSString*)mediaID maxId:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure;

-(void)getMedia:(NSString*)media comp:(void (^)(IGMedia* media))completion failure:(void (^)(NSError *))failure;
-(void)getMediaViews:(NSString*)mediaID maxId:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure;


-(void)logout;
-(BOOL) isLoggedIn;
-(MainUser*)loggedInUser;

@end

