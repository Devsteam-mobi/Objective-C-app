//
//  StartPageViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "StartPageViewController.h"
#import "MyPostsCell.h"
#import "BaseNavigationController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "AccountStateViewController.h"



@interface StartPageViewController ()

@end

@implementation StartPageViewController






-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9]];
    self.mainUser = [MainUser mainUser];
    
    BaseNavigationController * navControll = (BaseNavigationController*)self.navigationController;
    navControll.startViewController = self;
    

    
    if ([AppUtils isValidObject:self.mainUser.user]) {
        [self performSegueWithIdentifier:segue_showAccountState sender:@(_connected)];
    }
    else
    {
        [self performSegueWithIdentifier:segue_showAccountState sender:@(_not_connected)];
    }
    
}



-(void)leftMenuItemSelected:(UIButton*)sender
{
  
    if (sender.tag < 4)
    {
        if (self.selectedIndex == sender.tag) {
            BaseViewController * topViewController = (BaseViewController *)[AppUtils topViewController];
            [topViewController hideLeftMenuView];
            return;
        }
        else
        {
            [self.navigationController popToViewController:self animated:NO];
            self.selectedIndex = sender.tag;
        }
        
    }
    
    switch (sender.tag) {
        case 0:
        {
             [SVProgressHUD show];
            [self performSegueWithIdentifier:segue_showStatistics sender:nil];
        }
            break;
            
        case 1:
            [self performSegueWithIdentifier:segue_showMyPosts sender:nil];
            
            break;
        case 2:
        {
            [self performSegueWithIdentifier:segue_showAudience sender:nil];
        }
            break;
        case 3:
            [self performSegueWithIdentifier:segue_showEngagement sender:nil];
            break;
            
        case 4:
            [AppUtils openUrl:@"http://Devsteam.Mobi"];
            break;
       
            
        default:
            break;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:segue_showAccountState]) {
        
        AccountStateViewController * stateViewController = segue.destinationViewController;
        stateViewController.connectionState = [sender intValue];
        
    }
    
}


@end
