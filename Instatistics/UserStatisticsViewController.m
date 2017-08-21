//
//  UserStatisticsViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserStatisticsViewController.h"
#import "AppDelegate.h"
#import "CustomInputView.h"
#import "UserStatisticsTopMenuItem.h"
#import "UserStatisticsHorisontalInfoCell.h"
#import "UserStatisticsFollowInfoCell.h"
#import "LeftMenuView.h"
#import "UserEventsViewController.h"
#import "IGMedia.h"
#import "RegisteredUser.h"
#import "MainId.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "StalkersCell.h"


@interface UserStatisticsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (nonatomic,strong) UITapGestureRecognizer * navSingleTap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMenuHeight;

@property (weak, nonatomic) IBOutlet UIView *topMenuView;
@property (nonatomic, retain) NSString *followersMaxId;

@property (nonatomic, assign) NSInteger requestsCount;
@end

@implementation UserStatisticsViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setIitleUpImage:YES];
     _isVisible = YES;
    
 
}


-(void)logout:(MainUser*)mainUser
{
    
    [MainUser removeUser:mainUser];
    _usersToSwitch = [RegisteredUser allUsers];
    if (_usersToSwitch.count == 0) {
    [super logout];
        return;
    }
    
    RegisteredUser * user = _usersToSwitch[0];
    self.mainUser = user.currentUser;
    [self setIitleUpImage:YES];
    [self drawMenu];
    [self buildInterface];
    [self hideTopMenu];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _navSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchUsers:)];
    _navSingleTap.numberOfTapsRequired = 1;
    [self.navigationController.navigationBar addGestureRecognizer:_navSingleTap];
    [self.navigationController.navigationBar setUserInteractionEnabled:YES];
  
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _isVisible = NO;
    [self.navigationController.navigationBar removeGestureRecognizer:_navSingleTap];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    _navSingleTap = nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIImage *leftButtonImage = [UIImage imageNamed:@"menuButtonImage"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    
    UIImage *rightButtonImage = [UIImage imageNamed:@"refreshButtonImage"];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 38, 44);
    [button addTarget:self action:@selector(refreshButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:rightButtonImage forState:UIControlStateNormal];
    [button setImage:rightButtonImage forState:UIControlStateSelected];
    [button setImage:rightButtonImage forState:UIControlStateHighlighted];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
   
    
    
    
    
    
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(refreshButtonPressed:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
    
 
    [self drawMenu];
    _requestsCount = 0;
    
    
    if ([MainUser mainUser].isComplete == NO) {
        [self refreshButtonPressed:nil];
    }
    else
    {
        [self buildInterface];
    }
}


-(void)menuButtonPressed:(UIBarButtonItem *)item
{
    [super menuButtonPressed:item];
    [self hideTopMenu];

}



-(void)rotateRefreshButton
{
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1 * 0.5 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    
    [self.navigationItem.rightBarButtonItem.customView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


-(void)stopRefreshing
{
    [SVProgressHUD dismiss];
    [self.navigationItem.rightBarButtonItem.customView.layer removeAllAnimations];
}

-(void)drawMenu
{
    _topMenuView.backgroundColor = [AppUtils topMenuBackgroundColor];
    [_topMenuView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _usersToSwitch = [RegisteredUser allUsers];
    for (int i = 0; i< _usersToSwitch.count + 1; i++) {
        UserStatisticsTopMenuItem * item = [[[NSBundle mainBundle] loadNibNamed:@"UserStatisticsTopMenuItem" owner:nil options:nil] firstObject];
        item.target = self;
        if (i < _usersToSwitch.count) {
            RegisteredUser * user = _usersToSwitch[i];
            item.mainUser = user.currentUser;
        }
        else
        {
            item.mainUser = nil;
        }
        item.frame = CGRectMake(0, i* 35 , self.topMenuView.frame.size.width, 35);
        [self.topMenuView addSubview:item];
    }
}



-(void)buildInterface
{
    _requestsCount --;
    if (_requestsCount > 0) {
        return;
    }
    
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        _requestsCount = 0;
    }
    
    
    [SVProgressHUD dismiss];
    
    
    MainUser * firstRegisteredUser = [MainUser firstRegisteredUser];

    
    [MainUser addItemsFromArray:self.mainUser.userFollowers notContainedIn:firstRegisteredUser.userFollowers toArray:self.mainUser.userNewFollowers];
    [MainUser addItemsFromArray:firstRegisteredUser.userFollowers notContainedIn:self.mainUser.userFollowers toArray:self.mainUser.userLostFollowers];
    [MainUser addItemsFromArray:self.mainUser.userFollowings notContainedIn:firstRegisteredUser.userFollowings toArray:self.mainUser.userNewFollowings];
    
    [MainUser addItemsFromArray:self.mainUser.userFollowers containedIn:self.mainUser.userFollowings toArray:self.mainUser.userMutualFollowers];
    
    [MainUser addItemsFromArray:self.mainUser.userFollowings notContainedIn:self.mainUser.userFollowers toArray:self.mainUser.usersNotFollowMeBack];
    [MainUser addItemsFromArray:self.mainUser.userFollowers notContainedIn:self.mainUser.userFollowings toArray:self.mainUser.userIAmNotFollowingBack];
    
    [MainUser addCommentsFromArray:firstRegisteredUser.comments notContainedIn:self.mainUser.comments toArray:self.mainUser.deletedComments];
    [MainUser addLikersFromArray:firstRegisteredUser.likes notContainedIn:self.mainUser.likes toArray:self.mainUser.deletedLikes];

  
    
    NSString *photoUrl = @"";
    if (self.mainUser.photos.count) {
        IGMedia * media = self.mainUser.photos[0];
        photoUrl = media.image.standard_resolution;
    }
    
    
    [_topImage sd_setImageWithURL:[NSURL URLWithString:photoUrl]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    NSMutableArray *section = [NSMutableArray new];
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 8;
        [section addObject:cellSource];
    }
    {
        UserStatisticsHorisontalInfoCellSource *cellSource = [UserStatisticsHorisontalInfoCellSource new];
        cellSource.target = self;
        [section addObject:cellSource];
    }
   
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 8;
        [section addObject:cellSource];
    }
    
    {
        StalkersCellSource *cellSource = [StalkersCellSource new];
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 8;
        [section addObject:cellSource];
    }

    
    float height = 0;
    
    for (IDDCellSource * cellSource in section) {
        height += cellSource.staticHeightForCell;
    }
    
    {
        UserStatisticsFollowInfoCellSource *cellSource = [UserStatisticsFollowInfoCellSource new];
        cellSource.staticHeightForCell = ([AppUtils viewHeight] - self.tableView.frame.origin.y - 64) - height;
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    [self stopRefreshing];
}




-(void)setIitleUpImage:(BOOL)isUp
{

    UILabel * label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:_lato_font_black size:11];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[[self.mainUser.user.username uppercaseString] stringByAppendingString:@"  "]];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    
    textAttachment.image = isUp ? [UIImage imageNamed:@"arrowDownTitleStatistics"] : [UIImage imageNamed:@"arrowTitleStatistics"];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    [attributedString replaceCharactersInRange:NSMakeRange(attributedString.string.length - 1 , 1) withAttributedString:attrStringWithImage];
    label.attributedText = attributedString;
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
}



-(void)getFollowersForId:(NSString*)nextId
{
  
    MainUser *mainUser = [MainUser mainUser];
    
    [[InstagramAPI sharedInstance] getUserFollowers:self.mainUser.user.Id count:0 nextCursor:nextId comp:^(NSArray *response, IGPagination *pagination) {
        [MainUser addItems:response toArray:mainUser.userFollowers];
        if ([[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""] == NO) {
            [self getFollowersForId:pagination.nextMaxId];
         
        }
        else
        {
           [self buildInterface];
        }
    } failure:^(NSError *error) {
        [self stopRefreshing];
    }];

}


-(void)getFollowingsForId:(NSString*)nextId
{
    
    MainUser *mainUser = [MainUser mainUser];
    
    [[InstagramAPI sharedInstance] getUserFollowing:self.mainUser.user.Id count:0 nextCursor:nextId comp:^(NSArray *response, IGPagination *pagination) {
        [MainUser addItems:response toArray:mainUser.userFollowings];
        if ([[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""] == NO) {
            [self getFollowingsForId:pagination.nextMaxId];
        
        }
        else
        {
            [self buildInterface];
        }
    } failure:^(NSError *error) {
        [self stopRefreshing];
    }]; 
    
}

-(void)getLikesForId:(NSString*)nextId
{
    MainUser *mainUser = [MainUser mainUser];
    
    [[InstagramAPI sharedInstance] getUserFeed:self.mainUser.user.Id count:0 maxId:nextId getComments:YES comp:^(NSArray *response, IGPagination *pagination) {
        for (IGMedia* media in response) {
            
            
            for (IGUser * user in media.likes) {
                [MainUser addItem:user toArray:mainUser.likes];
            }
            
            for (IGComment * comment in media.comments) {
                [MainUser addItem:comment toArray:mainUser.comments];
            }

            if ([media.type isEqualToString:@"photo"]) {
                [MainUser addItem:media toArray:mainUser.photos];
            }
            else
            {
                [MainUser addItem:media toArray:mainUser.videos];
            }
            
        }
        if ([[AppUtils validateString:pagination.nextMaxId] isEqualToString:@""] == NO) {
            
            [self getLikesForId:pagination.nextMaxId];
            
        }
        else
        {
            [self buildInterface];
        }
    } failure:^(NSError *error) {
        [self stopRefreshing];
    }];
}




-(void)refreshButtonPressed:(UIBarButtonItem*)item
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self rotateRefreshButton];
    [SVProgressHUD show];
    [[InstagramAPI sharedInstance] getUser:self.mainUser.user.Id comp:^(IGUser *user) {
        
        MainUser *mainUser = [MainUser new];
        mainUser.isComplete = YES;
        user.password = self.mainUser.user.password;
        [mainUser setUser:user];
        [MainUser setMainUser:mainUser];
        
        self.mainUser = [MainUser mainUser];
        
        _requestsCount = 3;
        [self getFollowersForId:@""];
        [self getLikesForId:@""];
        [self getFollowingsForId:@""];
        
    } failure:^(NSError *error) {
        [self stopRefreshing];
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)switchUsers:(UIGestureRecognizer*)gestureRecognizer
{
    float height = (_usersToSwitch.count + 1) * 35;
    height = _topMenuHeight.constant == 0 ? height : 0;
    [self setIitleUpImage:height == 0];
    
    [UIView animateWithDuration:0.3 animations:^{
        _topMenuHeight.constant = height;
        self.blurView.alpha = _topMenuHeight.constant;
        [self.view layoutIfNeeded];
    }];
    
    
}

-(void)hideTopMenu
{
    [self setIitleUpImage:YES];
    [UIView animateWithDuration:0.3 animations:^{
        _topMenuHeight.constant = 0;
        self.blurView.alpha = self.blurView.tableView.frame.origin.x == 0;
        [self.view layoutIfNeeded];
    }];
}


-(void)selectUser:(IGUser*)user
{
    if (user.Id == self.mainUser.user.Id) {
        [self hideTopMenu];
    }
    
    else if ([AppUtils isValidObject:user] == NO) {
        [super logout];
    }
    
    else
    {
        [MainId setMainId:user.Id];
        self.mainUser = [MainUser mainUser];
        [self buildInterface];
        [self hideTopMenu];
        [self setIitleUpImage:YES];
        [self drawMenu];
    }
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:segue_showUserEvents]) {
        
        UserEventsViewController * events = segue.destinationViewController;
        events.userEventType = [sender intValue];
        
    }
    
}


@end
