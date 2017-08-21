//
//  UserPostsViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "UserPostsViewController.h"
#import "MyPostsCell.h"
#import "LeftMenuView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@interface UserPostsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fadedImage;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *fadedView;
@end

@implementation UserPostsViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        _itemsArray = [NSMutableArray new];
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"MY POSTS";
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    
    UIImage *leftButtonImage = [UIImage imageNamed:@"menuButtonImage"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    _fadedView.alpha = 0;
    
    
    self.topRefreshControl = [[UIRefreshControl alloc] init];
    //self.topRefreshControl.tintColor = [AppUtils spinerColor];
    
    self.topRefreshControl.tag = 0;
    [self.topRefreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.topRefreshControl atIndex:0];
    
    self.bottomRefreshControl = [UIRefreshControl new];
    self.bottomRefreshControl.triggerVerticalOffset = 100.;
    //self.bottomRefreshControl.tintColor = [AppUtils spinerColor];
    self.bottomRefreshControl.tag = 0;
    [self.bottomRefreshControl addTarget:self action:@selector(refreshBottom:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.bottomRefreshControl = self.bottomRefreshControl;
    
    [self loadItemsForId:@""];
   
}


-(void)loadItemsForId:(NSString*)maxId
{
   [[InstagramAPI sharedInstance] getUserFeed:self.mainUser.user.Id count:0 maxId:maxId getComments:NO comp:^(NSArray *response, IGPagination *pagination) {
            [_itemsArray addObjectsFromArray:response];
            self.pagination = pagination;
            [self buildInterface];
        } failure:^(NSError *error) {
            
        }];
 
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    
    if ([[AppUtils validateString:self.pagination.nextMinId] isEqualToString:@""] == NO)
    {
        [self loadItemsForId:self.pagination.nextMinId];
    }
    else
    {
        [self endRefreshing];
    }
}

- (void)refreshBottom:(UIRefreshControl *)refreshControl {
    
    if ([[AppUtils validateString:self.pagination.nextMaxId] isEqualToString:@""] == NO)
    {
        [self loadItemsForId:self.pagination.nextMaxId];
    }
    else
    {
        [self endRefreshing];
    }
    
}
-(void)endRefreshing
{
    
    [self.topRefreshControl endRefreshing];
    [self.bottomRefreshControl endRefreshing];
}


-(void)buildInterface
{
    
    NSMutableArray *section = [NSMutableArray new];
  
    
    for (IGMedia *media in _itemsArray)
    {
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
    if (_itemsArray.count == 0) {
        {
            
            MultiLineStringCellSource * cellSource = [MultiLineStringCellSource new];
            cellSource.backgroundColor = [UIColor clearColor];
            cellSource.textColor = [UIColor whiteColor];
            cellSource.infoText = @"NO POSTS";
            [section addObject:cellSource];
            
        }
        
    }
   
    [self endRefreshing];
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}


@end
