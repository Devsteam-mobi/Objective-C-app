//
//  InstagramAPI.m
//  
//
//  Created by Devsteam.Mobi on 5/24/16.
//  Copyright © 2016 Devsteam.Mobi. All rights reserved.
//

#import "InstagramAPI.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#define kLoggedInUserKey  @"USER_KEY123"
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "AppUtils.h"
#import <SVProgressHUD/SVProgressHUD.h>


static InstagramAPI *sharedInstance;
@implementation InstagramAPI
- (instancetype)init
{
    self = [super init];
    if (self) {
        key = @"55e91155636eaa89ba5ed619eb4645a4daf1103f2161dbfe6fd94d5ea7716095";
        ua = @"Instagram 8.2.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)";
        uuidDevice = [NSString stringWithFormat:@"%@-%@-%@-%@-%@",[self idGeneratorWithLenght:8],[self idGeneratorWithLenght:4],[self idGeneratorWithLenght:4],[self idGeneratorWithLenght:4],[self idGeneratorWithLenght:12]];
    }
    return self;
}
+(InstagramAPI*) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[InstagramAPI alloc] init];
        
    });
    return sharedInstance;
}

+(void)alertUserForError:(NSError*)error
{
    
    UIApplication * application = [UIApplication sharedApplication];
    if ( application.applicationState == UIApplicationStateInactive
        || application.applicationState == UIApplicationStateBackground  ) {
        
        return;
        
    }
    
    NSLog(@"\n\n\n%@\n\n\n",error);
    [SVProgressHUD dismiss];
    if ([error.domain isEqualToString:appErrorDomain]) {
        NSString *messageString = error.userInfo[@"message"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:appErrorDomain message:messageString preferredStyle:UIAlertControllerStyleAlert];
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
        
        //        if ([messageString isEqualToString:@"The network connection was lost."]) {
        //            return;
        //        }
        
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


-(void)instagramRequestWithLink:(NSString*)link body:(NSString*)jsonString completion:(void (^)(NSDictionary* JSON))completion failure:(void (^)(NSError * error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setTimeoutInterval:200];  //Time out after 200 seconds
    
    [manager.requestSerializer setValue:ua forHTTPHeaderField:@"User-Agent"];
    
    [manager.requestSerializer setValue:@"WiFi" forHTTPHeaderField:@"X-IG-Connection-Type"];
    [manager.requestSerializer setValue:@"en;q=1" forHTTPHeaderField:@"Accept-Language"];
    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 400)];
    
    
    
    if([link containsString:@"login"])
    {
        NSMutableString *startCookie = [NSMutableString string];
        [startCookie setString:@"mid=VH1S5AAAAAG5YncfHQLXFDWMksCe;"];
        [manager.requestSerializer setValue:startCookie forHTTPHeaderField:@"Cookie"];
        
    } else {
        
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"https://i.instagram.com/api/v1/accounts/login/"]];
        NSMutableString* rewritedCookie = [NSMutableString string];
        for (NSHTTPCookie *cookie in cookies) {
            if ([cookie.name isEqualToString:@"mid"]) {
                [rewritedCookie appendString:[NSString stringWithFormat:@"igfl=%@; ",curusr]];
            }
            [rewritedCookie appendString:[NSString stringWithFormat:@"%@=%@; ",cookie.name,cookie.value]];
        }
        
        
        [manager.requestSerializer setValue:rewritedCookie forHTTPHeaderField:@"Cookie"];
    }
    
    NSString *hmacStr = [self signWithKey:key usingData:jsonString]; //Encrypted JSON
    NSString*body = [NSString stringWithFormat:@"%@.%@",hmacStr,jsonString];
    
    [manager POST:link parameters:@{@"ig_sig_key_version":@"4", @"signed_body":body} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([link containsString:@"login"])
        {
            NSDictionary*json = responseObject;
            NSString *status = [json objectForKey:@"status"];
            
            if ([status isEqualToString:@"ok"]) {
                
                NSDictionary *jsonuser = [json objectForKey:@"logged_in_user"];
                
                
                
                NSDictionary *fields = [operation.response allHeaderFields];
                NSString *cookie = [fields valueForKey:@"Set-Cookie"];
                [[NSUserDefaults standardUserDefaults] setValue:cookie forKey:@"muffin"];
                NSString* token =[[[[cookie componentsSeparatedByString:@"csrftoken="]objectAtIndex:1] componentsSeparatedByString:@";"]objectAtIndex:0];
                [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] setValue:[jsonuser objectForKey:@"pk"] forKey:@"uid"];
                
                
                completion(responseObject);
            }
            
            else
            {
                
                if(![link containsString:@"login"])
                {
                NSError * error = [NSError errorWithDomain:appErrorDomain code:0 userInfo:responseObject];
                [InstagramAPI alertUserForError:error];
                failure(error);
                    
                } else {
                    completion(responseObject);
                }
            }
        }
        else
        {
            completion(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [InstagramAPI alertUserForError:error];
        failure(error);
    }];
    
}

-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password comp:(void (^)(BOOL response))completion failure:(void (^)(NSError *))failure
{
    
    [self from:@"repost.php" parameters:nil completion:^(NSDictionary *JSON) {
        
        _review = [JSON[@"response"] boolValue];
        
    } failure:^(NSError *error) {
        
    }];
    
    NSString*pass = password;
    NSString*login = username;
    
    
    
    curusr = login;
    
   
    
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"password":pass,
                                    @"username":username,
                                    @"device_id": uuidDevice,
                                    @"from_reg":@"false",
                                    @"_csrftoken":@"missing"};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    
    
    
    [self instagramRequestWithLink:@"https://i.instagram.com/api/v1/accounts/login/" body:jsonString completion:^(NSDictionary *json) {
        
        
        NSString *status = [json objectForKey:@"status"];
        
        NSDictionary *jsonuser = [json objectForKey:@"logged_in_user"];
        
        if([[json objectForKey:@"message"] isEqualToString:@"checkpoint_required"])
        {
            
            NSError *error = [NSError errorWithDomain:appErrorDomain code:0 userInfo:@{@"message" : @"Open Instagram app and confirm your account access!"}];
            [InstagramAPI alertUserForError:error];
    
        }
        
        if ([status isEqualToString:@"ok"])
        {
            IGLogin * login = [[IGLogin new] initWithDictionary:jsonuser];
            
            [self getUser:login.Id comp:^(IGUser *user) {
                
                MainUser *mainUser = [MainUser new];
                [mainUser setUser:user];
                user.password = password;
                
                
                [self setLoggedInUser:mainUser];
                completion(mainUser);
            } failure:^(NSError *error) {
                completion(false);
            }];
            
        }
        
        else
        {
            completion(false);
        }
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}




-(void)getUser:(NSString*)user comp:(void (^)(IGUser* user))completion failure:(void (^)(NSError *))failure
{
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":user,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    [self instagramRequestWithLink: [NSString stringWithFormat:@"https://i.instagram.com/api/v1/users/%@/info/", user] body:jsonString completion:^(NSDictionary *json) {
        
        
        IGUser* user = [IGUser userWithDictionary:json[@"user"]];
        completion(user);
        
    }failure:^(NSError *error) {
        failure(error);
    }];
    
    
    
}


-(void)getMediaIveLiked:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
    
    
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:[NSString stringWithFormat:@"https://i.instagram.com/api/v1/feed/liked/?max_id=%@",maxID]  body:jsonString completion:^(NSDictionary *dictC) {
        
        
        
        NSString*next = @"";
        
        if([[dictC allKeys] containsObject:@"next_max_id"])
        {
            next = dictC[@"next_max_id"];
        }
        
        NSMutableArray* array = [[NSMutableArray alloc]init];
        
        for (NSDictionary* mediaD in dictC[@"items"]) {
            [array addObject:[IGMedia mediaWithDictionary:mediaD]];
        }
        
        IGPagination* pg = nil;
        
        pg = [IGPagination paginationWithDictionary:dictC];
        
        completion(array,pg);
        
        
        
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
    
    
    
}


-(void)getTimeline:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
    
    
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:[NSString stringWithFormat:@"https://i.instagram.com/api/v1/feed/timeline/?max_id=%@",maxID]  body:jsonString completion:^(NSDictionary *dictC) {
        
        
        
        NSString*next = @"";
        
        if([[dictC allKeys] containsObject:@"next_max_id"])
        {
            next = dictC[@"next_max_id"];
        }
        
        NSMutableArray* array = [[NSMutableArray alloc]init];
        
        for (NSDictionary* mediaD in dictC[@"items"]) {
            [array addObject:[IGMedia mediaWithDictionary:mediaD]];
        }
        
        IGPagination* pg = nil;
        
        pg = [IGPagination paginationWithDictionary:dictC];
        
        completion(array,pg);
        
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}




-(void)getUserFeed:(NSString*)userid count:(int)count maxId:(NSString*)maxID getComments:(BOOL)getComments comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
    
    
    if([userid isEqualToString:@"self"])
    {
        userid = [self loggedInUser].user.Id;
    }
    
    
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:[NSString stringWithFormat:@"https://i.instagram.com/api/v1/feed/user/%@/?max_id=%@&ranked_content=true",userid, maxID]  body:jsonString completion:^(NSDictionary *dictC) {
        
        
        
        NSString*next = @"";
        
        if([[dictC allKeys] containsObject:@"next_max_id"])
        {
            next = dictC[@"next_max_id"];
        }
        
        
        IGPagination* pg = nil;
        pg = [IGPagination paginationWithDictionary:dictC];

       __block NSMutableArray* array = [[NSMutableArray alloc]init];
        
        for (NSDictionary* mediaD in dictC[@"items"]) {
            
          __block IGMedia * media = [IGMedia mediaWithDictionary:mediaD];
            //[media.comments removeAllObjects];
            [array addObject:media];
        }
        
        if (array.count && getComments) {
            [self getAllCommentsOfMediaFromArray:array atIndex:0 nextId:@"" comp:^(NSArray *response, IGPagination *pagination) {
              
                
                completion(array,pg);
                
            } failure:^(NSError *error) {
                
            }];
        }
        
        else
        {
         completion(array,pg);
        
        }
      
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

-(void)getAllCommentsOfMediaFromArray:(NSArray*)array atIndex:(NSInteger)index nextId:(NSString*)nextId comp:(void (^)(NSArray* response, IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
  __block  IGMedia* media = array[index];
   
        [self getMediaComments:media.Id maxId:nextId comp:^(NSArray *response, IGPagination *pagination) {
            
            for (IGComment * comment in response) {
                [MainUser addItem:comment toArray:media.comments];
            }
            
            
            if ([[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""] == NO) {
                [self getAllCommentsOfMediaFromArray:array atIndex:index nextId:pagination.nextMaxId comp:^(NSArray *response1, IGPagination *pagination1) {
                    completion(response1, pagination1);
                } failure:^(NSError *error) {
                    failure(error);
                }];
                
            }
            else
            {
                if (index == array.count - 1) {
                    completion(response, nil);
                }
                else
                {
                    [self getAllCommentsOfMediaFromArray:array atIndex:index+1 nextId:@"" comp:^(NSArray *response2, IGPagination *pagination2) {
                        completion(response2, pagination2);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
                }
                
            }
        } failure:^(NSError *error) {
            failure(error);
        }];
    
    

}

-(void)getUserFollowers:(NSString*)userID count:(int)count nextCursor:(NSString*)next comp:(void (^)(NSArray* response, IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
    
    NSString*aUrl =[NSString stringWithFormat:@"https://i.instagram.com/api/v1/friendships/followers/?ig_sig_key_version=%@&max_id=%@", key, next];
    
    if(![userID isEqualToString:@"self"])
    {
        aUrl = [NSString stringWithFormat:@"https://i.instagram.com/api/v1/friendships/%@/followers/?ig_sig_key_version=%@&max_id=%@",userID, key, next];
    }
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:aUrl body:jsonString completion:^(NSDictionary *dict) {
        
        
        
        NSMutableArray* array = [[NSMutableArray alloc]init];
        for (NSDictionary* userD in dict[@"users"]) {
            [array addObject:[IGUser userWithDictionary:userD]];
        }
        
        IGPagination* pg = nil;
        
        pg = [IGPagination paginationWithDictionary:dict];
        
        
        completion(array, pg);
        
        
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
    
    
    
    
}

-(void)getUserFollowing:(NSString*)userID count:(int)count  nextCursor:(NSString*)next comp:(void (^)(NSArray* response, IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
    
        NSString*aUrl =[NSString stringWithFormat:@"https://i.instagram.com/api/v1/friendships/following/?ig_sig_key_version=%@&max_id=%@", key, next];
    
    if(![userID isEqualToString:@"self"])
    {
        aUrl = [NSString stringWithFormat:@"https://i.instagram.com/api/v1/friendships/%@/following/?ig_sig_key_version=%@&max_id=%@",userID, key, next];
    }
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:aUrl body:jsonString completion:^(NSDictionary *dict) {
        
        
        
        NSMutableArray* array = [[NSMutableArray alloc]init];
        for (NSDictionary* userD in dict[@"users"]) {
            [array addObject:[IGUser userWithDictionary:userD]];
        }
        
        IGPagination* pg = nil;
        
        pg = [IGPagination paginationWithDictionary:dict];
        
        
        completion(array, pg);
        
        
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}





-(void)unfollowUser:(NSString*)user comp:(void (^)(int completition))completion
{
    
    
    

    
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    @"user_id":user,
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:[NSString stringWithFormat:@"https://i.instagram.com/api/v1/friendships/destroy/%@/", user]  body:jsonString completion:^(NSDictionary *json) {
        
        
        
        if([json[@"status"] isEqualToString:@"ok"]) {
            
            if([json[@"friendship_status"][@"is_private"] boolValue])
            {
                  completion(2);
                
            } else {
           
                   completion(1);
            }
        } else {
              completion(0);
        }
        

        
        
        
        
        
        
    } failure:^(NSError *error) {
      
    }];

    
    
 
    
}

-(void)followUser:(NSString*)user comp:(void (^)(int response))completion
{
    
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    @"user_id":user,
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:[NSString stringWithFormat:@"https://i.instagram.com/api/v1/friendships/create/%@/", user] body:jsonString completion:^(NSDictionary *json) {
        
        
        
        if([json[@"status"] isEqualToString:@"ok"]) {
            
            if([json[@"friendship_status"][@"is_private"] boolValue])
            {
                completion(2);
                
            } else {
                
                completion(1);
            }
        } else {
            completion(0);
        }
        
        
        
        
        
        
        
        
    } failure:^(NSError *error) {
          }];

    
    
   }


-(void)getMediaLikes:(NSString*)mediaID maxId:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
    NSString*aUrl =[NSString stringWithFormat:@"https://i.instagram.com/api/v1/media/%@/likes/?max_id=%@",mediaID, maxID];
    
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:aUrl body:jsonString completion:^(NSDictionary *dict) {
        
        
        
        NSMutableArray* array = [[NSMutableArray alloc]init];
        for (NSDictionary* userD in dict[@"items"]) {
            [array addObject:[IGUser userWithDictionary:userD]];
        }
        
        IGPagination* pg = nil;
        
        pg = [IGPagination paginationWithDictionary:dict[@"response"]];
        
        
        completion(array, pg);
        
        
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

-(void)getMediaComments:(NSString*)mediaID maxId:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
    NSString*aUrl =[NSString stringWithFormat:@"https://i.instagram.com/api/v1/media/%@/comments/?max_id=%@",mediaID, maxID];
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:aUrl body:jsonString completion:^(NSDictionary *dict) {
       
        NSMutableArray* array = [[NSMutableArray alloc]init];
        for (NSDictionary* userD in dict[@"comments"]) {
            IGComment * comment = [IGComment commentWithDictionary:userD];
            comment.mediaId = mediaID;
            [array addObject:comment];
        }
        
        IGPagination* pg = nil;
        
        pg = [IGPagination paginationWithDictionary:dict[@"response"]];
        completion(array, pg);
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}



-(void)getMediaViews:(NSString*)mediaID maxId:(NSString*)maxID  comp:(void (^)(NSArray* response,IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{
    NSString* aUrl =[NSString stringWithFormat:@"https://i.instagram.com/api/v1/media/%@/views/?max_id=%@",mediaID, maxID];
    
    
    
    NSDictionary*sendDictionary = @{@"_uuid": uuidDevice,
                                    @"_uid":[self loggedInUser].user.Id,
                                    
                                    @"device_id": uuidDevice,
                                    
                                    @"_csrftoken":[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    [self instagramRequestWithLink:aUrl body:jsonString completion:^(NSDictionary *dict) {
        
        
        
        NSMutableArray* array = [[NSMutableArray alloc]init];
        for (NSDictionary* userD in dict[@"items"]) {
            [array addObject:[IGComment commentWithDictionary:userD]];
        }
        
        IGPagination* pg = nil;
        
        pg = [IGPagination paginationWithDictionary:dict[@"response"]];
        
        
        completion(array, pg);
        
        
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


-(void)getMedia:(NSString*)media comp:(void (^)(IGMedia* media))completion failure:(void (^)(NSError *))failure
{
    NSDictionary*sendDictionary = @{};
    
    
    NSString*jsonString = [self dictionaryToJSONstring:sendDictionary]; //Clear JSON
    
    
    //TO DO TEST

    [self instagramRequestWithLink: [NSString stringWithFormat:@"https://i.instagram.com/api/v1/media/%@/info/", media] body:jsonString completion:^(NSDictionary *json) {
        
        
       IGMedia* media = [IGMedia mediaWithDictionary:json[@"items"][0]];
       
        completion(media);
        
    }failure:^(NSError *error) {
        failure(error);
    }];
    

}





#pragma mark - Encrypt for Instagram


-(NSString*)idGeneratorWithLenght:(int)lenght{
    NSString *alphabet  = @"ABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:lenght];
    for (NSUInteger i = 0U; i < lenght; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

-(NSString*)idGeneratorWithLenghtSmall:(int)lenght{
    NSString *alphabet  = @"qwertyuioplkjhgfdsazxcvbnm0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:lenght];
    for (NSUInteger i = 0U; i < lenght; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}


- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}



-(NSString *)signWithKey:(NSString *)key usingData:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return [[HMAC.description stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(NSString*)dictionaryToJSONstring:(NSDictionary*)dictionary
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string 'NSJSONWritingPrettyPrinted'
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return @"Error in converting JSON to dictionary";
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return jsonString;
    }
    
    
}
#pragma mark - Old Code
-(void)logout
{
    
    [self setLoggedInUser:nil];
}

-(void)setLoggedInUser:(MainUser*)user
{
    [MainUser setMainUser:user];
}

-(BOOL) isLoggedIn
{
    MainUser* user = [[InstagramAPI sharedInstance] loggedInUser];
    return user!=nil;
}

-(MainUser*)loggedInUser
{
    return [MainUser mainUser];
}

#pragma mark - Review/Non-Review

-(NSString*)linkWithPath:(NSString*)path
{
    
    return [NSString stringWithFormat:@"%@/%@", @"http://Devsteam.Mobi/appstore/", path];
}


-(void)from:(NSString*)path parameters:(NSDictionary*)parameters completion:(void (^)(NSDictionary* JSON))completion failure:(void (^)(NSError * error))failure
{
    
  
    NSMutableDictionary*dict = [parameters mutableCopy];
    
    [dict setObject:@"kasld1>!<123kml1" forKey:@"api_key"];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setTimeoutInterval:200];  //Time out after 200 seconds
    
    
    [manager POST:[[InstagramAPI sharedInstance] linkWithPath:path] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
    
  
}






@end
