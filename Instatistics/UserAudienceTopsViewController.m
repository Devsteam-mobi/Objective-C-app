//
//  UserAudienceTopsViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserAudienceTopsViewController.h"
#import "UserAudienceTopsCell.h"
#import "UserTopsExtendedCommentsCell.h"
#import "UserTopsExtendedLikeCell.h"
#import "UIButton+InfoObject.h"
#import "UserProfileViewController.h"


@interface UserAudienceTopsViewController ()
@property (weak, nonatomic) IBOutlet UIVisualEffectView *fadedView;
@property (weak, nonatomic) IBOutlet UIImageView *fadedImage;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (assign, nonatomic) BOOL showCommentsCount;
@end

@implementation UserAudienceTopsViewController



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
  
    
    NSArray * titlesArray = @[@"STALKERS",
                              @"MOST ENGAGED",
                              @"MOST TALKATIVE",
                              @"SEASONED INSTAGRAM USERS",
                              @"NEWEST INSTAGRAM USERS",
                              @"USERS I ENGAGE, BUT DON’T FOLLOW",
                              @"ADMIRERS",
                              @"MY EARLIEST FOLLOWERS",
                              @"USERS I’VE UNFOLLOWED",
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


-(NSArray*)mostEngaged
{
    
    RLMArray * userComments = self.mainUser.comments;
    RLMArray * userLikes = self.mainUser.likes;
    
   
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGComment * comment in userComments) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.Id == %@",comment.user.Id];
        dict[comment.user.Id] = @{@"user" : comment.user,
                                  @"orderBy" : @([userLikes objectsWithPredicate:predicate].count + [userComments objectsWithPredicate:predicate].count),
                                  };
    }
    
    for (IGLiker * liker in userLikes) {
        dict[liker.user.Id] = liker.user;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.Id == %@",liker.user.Id];
        dict[liker.user.Id] = @{@"user" : liker.user,
                                  @"orderBy" : @([userLikes objectsWithPredicate:predicate].count + [userComments objectsWithPredicate:predicate].count),
                                  };

    }
    
    return [dict allValues];
}

-(NSArray*)mostTalkative
{
    
    RLMArray * userComments = self.mainUser.comments;
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGComment * comment in userComments) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.Id == %@",comment.user.Id];
        dict[comment.user.Id] = @{@"user" : comment.user,
                                  @"orderBy" : @([userComments objectsWithPredicate:predicate].count),
                                  };
    }
    
    
    return [dict allValues];
}

-(NSArray*)seasonedUsers
{
    
    RLMArray * userFollowers = self.mainUser.userFollowers;
    
    NSMutableArray * array = [NSMutableArray new];
    NSInteger count = userFollowers.count - 1;
    
    count = count > 9 ? 9 : count;
    
    for (NSInteger i = count  ; i >= 0; i--) {
        
        IGUser * user = userFollowers[i];
        [array addObject:@{@"user" : user,
                           @"orderBy" : @"",
                           }];
        if (i == userFollowers.count) {
            break;
        }
    }

    
    
    return array;
}

-(NSArray*)newestUsers
{
    
    RLMArray * userFollowers = self.mainUser.userFollowers;
    
    NSMutableArray * array = [NSMutableArray new];
    
    NSInteger count = userFollowers.count;
    
    count = count > 10 ? 10 : count;

    
    for (int i = 0; i < count; i++) {
        IGUser * user = userFollowers[i];
        [array addObject:@{@"user" : user,
                           @"orderBy" : @"",
                           }];
        if (i == userFollowers.count) {
            break;
        }
    }
    
    
    
    return array;
}

-(void)checkMyEngagementsForId:(NSString*)nextId withDictionary:(NSMutableDictionary*)dict
{
    [[InstagramAPI sharedInstance] getMediaIveLiked:nextId comp:^(NSArray *response, IGPagination *pagination) {
        
     
        for (IGMedia *media in response) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",media.user.Id];
            RLMResults *result = [self.mainUser.userFollowings objectsWithPredicate:predicate];
            
            if (result.count == 0)
            {
                
                dict[media.user.Id] = @{@"user" : media.user,
                                        @"orderBy" : @"",
                                  };


            }
        }
        
        
        
        if ([[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""] == NO) {
            [self checkMyEngagementsForId:pagination.nextMaxId withDictionary:dict];
            
            
        }
        else
        {
            [_itemsArray addObjectsFromArray:[dict allValues]];
            [self buildUsersInterfaceForFullArea:YES showLikesAndCommentsCount:NO];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}


-(void)earliestFollowers:(NSString*)nextMaxId withDictionary:(NSMutableDictionary*)dict
{
   
    [[InstagramAPI sharedInstance] getUserFollowers:self.mainUser.user.Id count:0 nextCursor:nextMaxId comp:^(NSArray *response, IGPagination *pagination) {
        for (IGUser *user in response) {
            
            dict[user.Id] = @{@"user" : user,
                              @"orderBy" : @"",
                              };
            if (dict.allValues.count >=10) {
                break;
            }
        }
        if ([[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""] == NO && dict.allValues.count >=10) {
            [self earliestFollowers:pagination.nextMaxId withDictionary:dict];
        }
        else
        {
            [_itemsArray addObjectsFromArray:[dict allValues]];
            
            while (_itemsArray.count > 10) {
                [_itemsArray removeObjectAtIndex:0];
            }
            
            [self buildUsersInterfaceForFullArea:YES showLikesAndCommentsCount:NO];
        }
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)unfollowedUsers:(NSString*)nextMaxId withDictionary:(NSMutableDictionary*)dict
{
    
    
    [[InstagramAPI sharedInstance] getUserFollowing:self.mainUser.user.Id count:0 nextCursor:nextMaxId comp:^(NSArray *response, IGPagination *pagination) {
        [_itemsArray addObjectsFromArray:response];
        if ([[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""] == NO) {
            [self unfollowedUsers:pagination.nextMaxId withDictionary:dict];
        }
        else
        {
            for (IGUser * user in self.mainUser.userFollowings) {
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",user.Id];
                ///RLMResults *result = [self.mainUser.userFollowers objectsWithPredicate:predicate];
                
                
                NSArray * results = [_itemsArray filteredArrayUsingPredicate:predicate];
                
                
                if (results.count == 0)
                {
                    dict[user.Id] = @{@"user" : user,
                                      @"orderBy" : @"",
                                      };
                }
                
            }
            [_itemsArray removeAllObjects];
            [_itemsArray addObjectsFromArray:[dict allValues]];
            [self buildUsersInterfaceForFullArea:YES showLikesAndCommentsCount:NO];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}


-(NSArray*)userAdmirers
{
    
    RLMArray * userComments = self.mainUser.comments;
    RLMArray * userLikes = self.mainUser.likes;
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGComment * comment in userComments) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",comment.user.Id];
        
        
        RLMResults * result = [self.mainUser.userFollowers objectsWithPredicate:predicate];
        
        if (result.count == 0) {
            dict[comment.user.Id] = @{@"user" : comment.user,
                                      @"orderBy" : @"",
                                      };
        }
        
    }
    
    for (IGLiker * liker in userLikes) {
        
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Id == %@",liker.user.Id];
        RLMResults * result = [self.mainUser.userFollowers objectsWithPredicate:predicate];
        
        if (result.count == 0) {

        
        dict[liker.user.Id] = @{@"user" : liker.user,
                                @"orderBy" : @""
                                };
        
        }
    }
    
    return [dict allValues];
}


-(NSArray*)stalkers
{
    
    RLMArray * likes = self.mainUser.likes;

    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGLiker * liker in likes) {
        
        if ([AppUtils isValidObject: dict[liker.user.Id]]) {
            dict[liker.user.Id] = @{@"user" : liker.user,
                                    @"orderBy" : @([dict[liker.user.Id][@"orderBy"] integerValue] + 1),
                                    };
        }
        
        else
        {
            dict[liker.user.Id] = @{@"user" : liker.user,
                                    @"orderBy" : @(1),
                                    };
        }
        
    }
    
    
    return [dict allValues];
}


-(void)buildInterface
{
    BOOL fullArea = NO;
    BOOL showLikesAndCommentsCount = YES;
    _showCommentsCount = YES;
    switch (_selectedItem) {
            
        case 0:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self stalkers]];
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderBy" ascending:NO];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            [_itemsArray sortUsingDescriptors:sortDescriptors];
            fullArea = YES;
        }
            break;
            
        case 1:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self mostEngaged]];
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderBy" ascending:NO];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            [_itemsArray sortUsingDescriptors:sortDescriptors];
        }
            break;
        case 2:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self mostTalkative]];
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderBy" ascending:NO];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            [_itemsArray sortUsingDescriptors:sortDescriptors];
        }
            break;
        case 3:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self seasonedUsers]];
            fullArea = YES;
        }
            break;
        case 4:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self newestUsers]];
            fullArea = YES;
        }
            break;
        case 5:
        {
           __block NSMutableDictionary * dict = [NSMutableDictionary new];
            showLikesAndCommentsCount = NO;
            [self checkMyEngagementsForId:@"" withDictionary:dict];
        }
            break;
        case 6:
        {
            _itemsArray = [NSMutableArray arrayWithArray:[self userAdmirers]];
            showLikesAndCommentsCount = NO;
            fullArea = YES;
        }
            break;
        case 7:
        {
            __block NSMutableDictionary * dict = [NSMutableDictionary new];
            showLikesAndCommentsCount = NO;
            [self earliestFollowers:@"" withDictionary:dict];
        }

            break;
        case 8:
        {
            __block NSMutableDictionary * dict = [NSMutableDictionary new];
            showLikesAndCommentsCount = NO;
            [self unfollowedUsers:@"" withDictionary:dict];
        }

            break;
            
        default:
            break;
    }
    
     [self buildUsersInterfaceForFullArea:fullArea showLikesAndCommentsCount:showLikesAndCommentsCount];
}




-(void)buildUsersInterfaceForFullArea:(BOOL)fullArea showLikesAndCommentsCount:(BOOL)showLikesAndCommentsCount
{
    NSMutableArray *section = [NSMutableArray new];
    
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
        RLMResults * comments = [self.mainUser.comments objectsWithPredicate:predicate];
        {
            {
                UserAudienceTopsCellSource * cellSource = [UserAudienceTopsCellSource new];
                cellSource.target = self;
                cellSource.selector = fullArea ? @selector(chooseUser:) : @selector(chooseProfile:);
                cellSource.profileSelector = @selector(chooseUser:);
                cellSource.likesCount = likers.count;
                cellSource.commentsCount = comments.count;
                cellSource.user = user;
                cellSource.showLikesAndCommentsCount = showLikesAndCommentsCount;
                cellSource.isSelected = [_selectedItemId isEqualToString:user.Id];
                [section addObject:cellSource];
            }
            
            if (fullArea == NO) {
                if ([_selectedItemId isEqualToString:user.Id])
                {
                    BOOL isMediaLikedByUser = NO;
                    for (IGLiker *liker in likers)
                    {
                        NSPredicate *mediaPredicate = [NSPredicate predicateWithFormat:@"self.mediaId == %@",liker.mediaId];
                        isMediaLikedByUser += [comments objectsWithPredicate:mediaPredicate].count;
                        if ([comments objectsWithPredicate:mediaPredicate].count == 0 && _selectedItem == 0) {
                            UserTopsExtendedLikeCellSource * cellSource = [UserTopsExtendedLikeCellSource new];
                            cellSource.target = self;
                            cellSource.liker = liker;
                            cellSource.selector = @selector(showPhoto:);
                            [section addObject:cellSource];
                        }
                        
                    }
                    
                    if (comments.count) {
                        
                        UserTopsExtendedCommentsCellSource * cellSource = [UserTopsExtendedCommentsCellSource new];
                        cellSource.target = self;
                        cellSource.comments = comments;
                        cellSource.selector = @selector(showPhoto:);
                        cellSource.liked = isMediaLikedByUser;
                        [section addObject:cellSource];
                        
                    }
                    
                }
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


-(IBAction)chooseProfile:(UIButton*)sender
{
    IGUser *user = sender.infoObject;
    
   
        if ([_selectedItemId isEqualToString:user.Id]) {
            _selectedItemId = @"";
            [self buildInterface];
            return;
        }
        _selectedItemId = user.Id;
        [self buildInterface];
        return;
}

- (IBAction)hidePhoto:(id)sender {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        _fadedView.alpha = 0.0;
    }];

}

-(IBAction)showPhoto:(UIButton*)sender
{
    
    IGMedia *media = sender.infoObject;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [_fadedImage sd_setImageWithURL:[NSURL URLWithString:media.image.standard_resolution] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
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
