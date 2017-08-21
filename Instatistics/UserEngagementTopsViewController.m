//
//  UserEngagementTopsViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserEngagementTopsViewController.h"
#import "MyPostsCell.h"
#import "UIButton+InfoObject.h"
#import "UserProfileViewController.h"
#import "UserEventsCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@interface UserEngagementTopsViewController ()

@property (weak, nonatomic) IBOutlet UIVisualEffectView *fadedView;
@property (weak, nonatomic) IBOutlet UIImageView *fadedImage;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation UserEngagementTopsViewController



- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _selectedItemId = @"";
        _itemsArray = [NSMutableArray new];
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
    NSArray * titlesArray = @[@"MOST ENGAGED PHOTOS, LAST 7 DAYS",
                              @"MOST ENGAGED PHOTOS, LAST 30 DAYS",
                              @"MOST ENGAGED PHOTOS, ALL TIME",
                              @"MOST ENGAGED VIDEOS, LAST 7 DAYS",
                              @"MOST ENGAGED VIDEOS, LAST 30 DAYS",
                              @"MOST ENGAGED VIDEOS, ALL TIME",
                              @"NEAREST FOLLOWERS",
                              @"FARTHEST FOLLOWERS",
                              @"GHOST FOLLOWERS",
                              @"LEAST LIKES GIVEN",
                              @"LEAST COMMENTS LEFT"
                              ];
    
    self.title = titlesArray[_selectedItem];
    
   
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    _fadedView.alpha = 0;
    [self buildInterface];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
   
}


-(NSArray*)mostEngagedPhotosLast:(NSInteger)days
{
    
    RLMArray * userPhotos = self.mainUser.photos;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.created_time > %ld",(long)[[NSDate date] timeIntervalSince1970] - days * 24 * 60 * 60];
    RLMResults * results = [userPhotos objectsWithPredicate:predicate];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGMedia * photo in results)
    {
        dict[photo.Id] = @{@"media" : photo,
                           @"orderBy" : @([photo.comment_count integerValue]+ [photo.likes_count integerValue]),
                           };
    }
    
    
    return [dict allValues];
}

-(NSArray*)mostEngagedVideosLast:(NSInteger)days
{
    
    RLMArray * userPhotos = self.mainUser.videos;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.created_time > %ld",(long)[[NSDate date] timeIntervalSince1970] - days * 24 * 60 * 60];
    RLMResults * results = [userPhotos objectsWithPredicate:predicate];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGMedia * video in results)
    {
        dict[video.Id] = @{@"media" : video,
                           @"orderBy" : @([video.comment_count integerValue]+ [video.likes_count integerValue]),
                           };
    }
    
    
    return [dict allValues];
}

-(NSArray*)ghostFollowers
{
    
    RLMArray * userFollowers = self.mainUser.userFollowers;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    for (IGUser * user in userFollowers)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.Id == %@",user.Id];
        if ([self.mainUser.comments objectsWithPredicate:predicate].count == 0 && [self.mainUser.likes objectsWithPredicate:predicate].count == 0) {
            dict[user.Id] = @{@"user" : user,
                              @"orderBy" : @(0),
                              };
        }
        
    }
    return [dict allValues];
}


-(void)closestFollwowers
{
    
    [self closestFollowersInArray:(NSArray*)self.mainUser.userFollowers atIndex:0 nextMaxId:@"" comp:^(NSArray *response, IGPagination *pagination) {
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderBy" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        [_itemsArray sortUsingDescriptors:sortDescriptors];
        
        [self buildMediasInterface];
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)farthestFollwowers
{
    
    [self closestFollowersInArray:(NSArray*)self.mainUser.userFollowers atIndex:0 nextMaxId:@"" comp:^(NSArray *response, IGPagination *pagination) {
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderBy" ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        [_itemsArray sortUsingDescriptors:sortDescriptors];
        
        [self buildMediasInterface];
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)closestFollowersInArray:(NSArray*)array atIndex:(NSInteger)index nextMaxId:(NSString*)nextMaxId comp:(void (^)(NSArray* response, IGPagination *pagination))completion failure:(void (^)(NSError *))failure
{

    IGUser* user = array[index];
    [[InstagramAPI sharedInstance]getUserFeed:user.Id count:0 maxId:nextMaxId getComments:NO comp:^(NSArray *response, IGPagination *pagination) {
        
        
        
        for (IGMedia * media in response) {
            
            if ([AppUtils isValidObject:media.location]) {
                
                if ([AppUtils isValidObject:media.location.latitude] && [AppUtils isValidObject:media.location.longitude]) {
                    
                    CLLocation * location = [[CLLocation new] initWithLatitude:[media.location.latitude doubleValue] longitude:[media.location.longitude doubleValue]];
                    
                    [_itemsArray addObject:@{@"user" : user,
                                             @"orderBy" : @([location distanceFromLocation:_userLocation]),
                                             }];
                    break;
                }
            }
            
        }
        
        
        if ([[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""] == NO && _itemsArray.count == index) {
            [self closestFollowersInArray:array atIndex:index nextMaxId:pagination.nextMaxId comp:^(NSArray *response1, IGPagination *pagination1) {
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
                
                [self closestFollowersInArray:array atIndex:index+1 nextMaxId:@"" comp:^(NSArray *response2, IGPagination *pagination2) {
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

-(NSArray*)leastLikesGiven
{
    
    RLMArray * userPhotos = self.mainUser.photos;
    RLMArray * userVideos = self.mainUser.videos;
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGMedia * photo in userPhotos)
    {
        dict[photo.Id] = @{@"media" : photo,
                           @"orderBy" : @([photo.likes_count integerValue]),
                           };
    }
    
    for (IGMedia * video in userVideos)
    {
        dict[video.Id] = @{@"media" : video,
                           @"orderBy" : @([video.likes_count integerValue]),
                           };
    }
    
    return [dict allValues];
}

-(NSArray*)leastCommented
{
    
    RLMArray * userPhotos = self.mainUser.photos;
    RLMArray * userVideos = self.mainUser.videos;
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGMedia * photo in userPhotos)
    {
        dict[photo.Id] = @{@"media" : photo,
                           @"orderBy" : @([photo.comment_count integerValue]),
                           };
    }
    
    for (IGMedia * video in userVideos)
    {
        dict[video.Id] = @{@"media" : video,
                           @"orderBy" : @([video.comment_count integerValue]),
                           };
    }
    
    return [dict allValues];
}

-(void)buildInterface
{

    BOOL sortAscending = NO;
    switch (_selectedItem) {
        case 0:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self mostEngagedPhotosLast:7]];
        }
            break;
        case 1:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self mostEngagedPhotosLast:30]];
           
        }
            break;
        case 2:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self mostEngagedPhotosLast:pow(10, 6)]];
        }
            break;
        case 3:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self mostEngagedVideosLast:7]];
        }
            break;
        case 4:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self mostEngagedVideosLast:30]];
        }
            break;
        case 5:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self mostEngagedVideosLast:pow(10, 6)]];
        }
            break;
        case 6:
        {
            [self closestFollwowers];
        }

            break;
        case 7:
        {
            [self farthestFollwowers];
        }
            break;
        case 8:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self ghostFollowers]];
        }

            break;
        case 9:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self leastLikesGiven]];
            sortAscending = YES;
        }
            
            break;
        case 10:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self leastCommented]];
            sortAscending = YES;
        }
            
            break;
        default:
            break;
    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderBy" ascending:sortAscending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [_itemsArray sortUsingDescriptors:sortDescriptors];
    
     [self buildMediasInterface];
}




-(void)buildMediasInterface
{
    NSMutableArray *section = [NSMutableArray new];
    
    if (_selectedItem == 7 || _selectedItem == 6 || _selectedItem == 8) {
        for (NSDictionary * dict in _itemsArray)
        {
            
            IGUser * user = dict[@"user"];
            
            {
                SpaceCellSource * cellSource = [SpaceCellSource new];
                cellSource.backgroundColor = [UIColor whiteColor];
                [section addObject:cellSource];
            }
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.Id == %@",user.Id];
            RLMResults * likers = [self.mainUser.likes objectsWithPredicate:predicate];
            {
                UserEventsCellSource * cellSource = [UserEventsCellSource new];
                cellSource.target = self;
                cellSource.selector = @selector(chooseUser:);
                cellSource.profileSelector = @selector(chooseUser:);
                cellSource.userEventType = 1000;
                cellSource.user = user;
                cellSource.showDistance = _selectedItem == 6 || _selectedItem == 7;
                cellSource.eventsCount = _selectedItem == 8 ? likers.count : [dict[@"orderBy"] integerValue]/1000;
                cellSource.selected = [_selectedItemId isEqualToString:user.Id];
                [section addObject:cellSource];
            }
            
            
        }

    }
    else
    {
        for (NSDictionary * dict in _itemsArray)
        {
            
            IGMedia * media = dict[@"media"];
            {
                SpaceCellSource * cellSource = [SpaceCellSource new];
                cellSource.backgroundColor = [UIColor whiteColor];
                [section addObject:cellSource];
            }
            
            {
                MyPostsCellSource * cellSource = [MyPostsCellSource new];
                cellSource.media = media;
                cellSource.selector = @selector(showPhoto:);
                cellSource.target = self;
                [section addObject:cellSource];
            }
            
            
        }
    }
    
    
    if (_itemsArray.count == 0) {
        {
            
            MultiLineStringCellSource * cellSource = [MultiLineStringCellSource new];
            cellSource.backgroundColor = [UIColor clearColor];
            cellSource.textColor = [UIColor blackColor];
            cellSource.infoText = @"EMPTY LIST";
            [section addObject:cellSource];
            
        }
        
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
}




-(IBAction)chooseUser:(UIButton*)sender
{
    
    [self performSegueWithIdentifier:segue_showUserProfile sender:sender.infoObject];
    
}




- (IBAction)hidePhoto:(id)sender {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        _fadedView.alpha = 0.0;
    }];

}

-(IBAction)showPhoto:(UIButton*)sender
{
    
    IGMedia * media = sender.infoObject;
    
    if ([media.type isEqualToString:@"video"]) {
        NSURL *videoURL = [NSURL URLWithString:media.video.standard_resolution];
        
        // create an AVPlayer
        AVPlayer *player = [AVPlayer playerWithURL:videoURL];
        
        // create a player view controller
        AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
        controller.player = player;
        
        
        // show the view controller
        [self presentViewController:controller animated:YES completion:^{
            [player play];
        }];
        return;
    }
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [_fadedImage sd_setImageWithURL:[NSURL URLWithString:media.image.standard_resolution]];
    [UIView animateWithDuration:0.5 animations:^{
        _fadedView.alpha = 1.0;
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segue_showUserProfile]) {
        UserProfileViewController * profile = segue.destinationViewController;
        profile.followerUser = sender;
    }
    
}


@end
