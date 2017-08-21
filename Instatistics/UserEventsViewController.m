//
//  UserEventsViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserEventsViewController.h"
#import "UserEventsCell.h"
#import "UserEventsExtendedCommentsCell.h"
#import "UserEventsExtendedLikeCell.h"
#import "UIButton+InfoObject.h"
#import "UserProfileViewController.h"


@interface UserEventsViewController ()
@property (weak, nonatomic) IBOutlet UIVisualEffectView *fadedView;
@property (weak, nonatomic) IBOutlet UIImageView *fadedImage;
@property (strong, nonatomic) RLMArray *itemsArray;
@property (strong, nonatomic) NSString *emptyListString;
@end

@implementation UserEventsViewController



- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _selectedItemId = @"";
        _emptyListString = @"";
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
    NSArray * titlesArray = @[@"FOLLOWERS",
                              @"LOST",
                              @"FOLLOWING",
                              @"MUTUAL",
                              @"UNREQUITED",
                              @"ONE WAY",
                              @"DELETED COMMENTS",
                              @"DELETED LIKES",
                              ];
    
    self.title = titlesArray[_userEventType];
    
   
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    _fadedView.alpha = 0;
    [self buildInterface];
    self.tableView.backgroundColor = [UIColor whiteColor];
}



-(void)buildInterface
{
    
    switch (_userEventType) {
        case _new_followers:
        {
            _itemsArray = self.mainUser.userNewFollowers;
            _emptyListString = @"NO NEW FOLLOWERS";
            [self buildUsersInterface];
        }
            break;
        case _lost_followers:{
            _itemsArray = self.mainUser.userLostFollowers;
            _emptyListString = @"NO LOST FOLLOWERS";
            [self buildUsersInterface];
        }

            break;
        case _new_followings:{
            _itemsArray = self.mainUser.userNewFollowings;
            _emptyListString = @"NO NEW FOLLOWINGS";
            [self buildUsersInterface];
            }
            break;
        case _mutual:{
            _itemsArray = self.mainUser.userMutualFollowers;
            _emptyListString = @"NO MUTUAL FOLLOWERS";
            [self buildUsersInterface];
        }

            break;
        case _not_following_me_back:{
            _itemsArray = self.mainUser.usersNotFollowMeBack;
            _emptyListString = @"NO UNREQUITED FOLLOWINGS";
            [self buildUsersInterface];
        }

            break;
        case _i_am_not_following_back:{
            _itemsArray = self.mainUser.userIAmNotFollowingBack;
            _emptyListString = @"NO UNREQUITED FOLLOWINGS";
            [self buildUsersInterface];
        }

            break;
        case _deleted_comments:{
            _itemsArray = self.mainUser.deletedComments;
            _emptyListString = @"NO DELETED COMMENTS";
            [self buildDeletedCommentsInterface];
        }

            break;
        case _deleted_likes:{
            _itemsArray = self.mainUser.deletedLikes;
            _emptyListString = @"NO DELETED COMMENTS";
            [self buildDeletedLikesInterface];
        }

            break;
        default:
            break;
    }
    
    
}








-(void)buildDeletedCommentsInterface
{
    NSMutableArray *section = [NSMutableArray new];
    
    NSMutableSet * users = [NSMutableSet new];
    NSMutableSet * userIds = [NSMutableSet new];
    for (IGComment *comment in _itemsArray)
    {
        if ([userIds containsObject:comment.user.Id] == NO) {
            [users addObject:comment.user];
            [userIds addObject:comment.user.Id];
        }
        
    }
    
    
    
    for (IGUser *user in users)
    {
        
        {
            SpaceCellSource * cellSource = [SpaceCellSource new];
            cellSource.backgroundColor = [UIColor whiteColor];
            [section addObject:cellSource];
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.Id == %@",user.Id];
        RLMResults * comments = [_itemsArray objectsWithPredicate:predicate];
        {
            UserEventsCellSource * cellSource = [UserEventsCellSource new];
            cellSource.eventsCount = comments.count;
            cellSource.target = self;
            cellSource.selector = @selector(chooseProfile:);
            cellSource.profileSelector = @selector(chooseUser:);
            cellSource.userEventType = _userEventType;
            cellSource.user = user;
            cellSource.isSelected = [_selectedItemId isEqualToString:user.Id];
            [section addObject:cellSource];
        }
        
        
        if ([_selectedItemId isEqualToString:user.Id]) {
            
            
            for (IGComment *comment in comments)
            {
                UserEventsExtendedCommentsCellSource * cellSource = [UserEventsExtendedCommentsCellSource new];
                cellSource.target = self;
                cellSource.comment = comment;
                cellSource.selector = @selector(showPhoto:);
                [section addObject:cellSource];
            }
        }
        
    }
    
    if (users.count == 0) {
        {
            
            MultiLineStringCellSource * cellSource = [MultiLineStringCellSource new];
            cellSource.backgroundColor = [UIColor clearColor];
            cellSource.textColor = [UIColor blackColor];
            cellSource.infoText = _emptyListString;
            [section addObject:cellSource];
            
        }
        
    }


    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
}

-(void)buildDeletedLikesInterface
{
    NSMutableArray *section = [NSMutableArray new];
    
    NSMutableSet * users = [NSMutableSet new];
    NSMutableSet * userIds = [NSMutableSet new];
    for (IGLiker *liker in _itemsArray)
    {
        if ([userIds containsObject:liker.user.Id] == NO) {
            [users addObject:liker.user];
            [userIds addObject:liker.user.Id];
        }
        
    }

    
    
    
    for (IGUser *user in users)

    {
        
        {
            SpaceCellSource * cellSource = [SpaceCellSource new];
            cellSource.backgroundColor = [UIColor whiteColor];
            [section addObject:cellSource];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.Id == %@",user.Id];
        RLMResults * likers = [_itemsArray objectsWithPredicate:predicate];

        {
            UserEventsCellSource * cellSource = [UserEventsCellSource new];
            cellSource.target = self;
            cellSource.selector = @selector(chooseProfile:);
            cellSource.profileSelector = @selector(chooseUser:);
            cellSource.userEventType = _userEventType;
            cellSource.user = user;
            cellSource.eventsCount = likers.count;
            cellSource.selected = [_selectedItemId isEqualToString:user.Id];
            [section addObject:cellSource];
        }
        
        
            if ([_selectedItemId isEqualToString:user.Id])
            {
                
                for (IGLiker *liker in likers)
                {
                    UserEventsExtendedLikeCellSource * cellSource = [UserEventsExtendedLikeCellSource new];
                    cellSource.target = self;
                    cellSource.liker = liker;
                    cellSource.selector = @selector(showPhoto:);
                    [section addObject:cellSource];
                }
            }
    }

    if (users.count == 0) {
        {
            
            MultiLineStringCellSource * cellSource = [MultiLineStringCellSource new];
            cellSource.backgroundColor = [UIColor clearColor];
            cellSource.textColor = [UIColor blackColor];
            cellSource.infoText = _emptyListString;
            [section addObject:cellSource];
            
        }
        
    }

    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
}


-(void)buildUsersInterface
{
    NSMutableArray *section = [NSMutableArray new];
    
    for (IGUser *user in _itemsArray)
    {
        
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
            cellSource.selector = @selector(chooseProfile:);
            cellSource.profileSelector = @selector(chooseUser:);
            cellSource.userEventType = _userEventType;
            cellSource.user = user;
            cellSource.eventsCount = likers.count;
            cellSource.selected = [_selectedItemId isEqualToString:user.Id];
            [section addObject:cellSource];
        }
        
        
    }
    if (_itemsArray.count == 0) {
        {
            
            MultiLineStringCellSource * cellSource = [MultiLineStringCellSource new];
            cellSource.backgroundColor = [UIColor clearColor];
            cellSource.textColor = [UIColor blackColor];
            cellSource.infoText = _emptyListString;
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
    
    if (_userEventType == _deleted_likes || _userEventType == _deleted_comments) {
        if ([_selectedItemId isEqualToString:user.Id]) {
            _selectedItemId = @"";
            [self buildInterface];
            return;
        }
        _selectedItemId = user.Id;
        [self buildInterface];
        return;
    }
    
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
