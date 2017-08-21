//
//  BaseViewController.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppConstants.h"
#import "AppUtils.h"
#import "IGUser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LeftMenuView.h"
#import "CloseCrossButtonCell.h"
#import "InstagramAPI.h"
#import "MultiLineStringCell.h"
#import "SeparatorPaddingCell.h"
#import "UIButton+InfoObject.h"
#import "MainUser.h"


@interface BaseViewController : UIViewController

@property (nonatomic,retain) MainUser *mainUser;
@property (nonatomic,assign) CGFloat keyboardHeight;
@property (nonatomic,assign) NSTimeInterval keyboardAnimationDuration;
@property (nonatomic, assign)  NSInteger selectedIndex;
@property (weak, nonatomic) IBOutlet LeftMenuView *blurView;
@property (nonatomic, assign) BOOL statusBarHidden;

-(void)logout;
-(BaseViewController*)startPage;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
-(IBAction)openUpgradeViewController:(UIButton*)sender;
-(void)hideLeftMenuView;

-(void)menuButtonPressed:(UIBarButtonItem*)item;
-(IBAction)buyItem:(UIButton*)sender;

@end
