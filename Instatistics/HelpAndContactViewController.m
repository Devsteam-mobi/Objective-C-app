//
//  HelpAndContactViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "HelpAndContactViewController.h"
#import "AppDelegate.h"
#import "CustomInputView.h"
#import "BaseNavigationController.h"
#import "AccountStateViewController.h"


@interface HelpAndContactViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *loginWebview;

@end

@implementation HelpAndContactViewController




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = _requestName ? @"Contact us" : @"Help";
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
   NSString * urlString = _requestName ? @"https://www.google.com" : @"https://www.yahoo.com";
    
    NSURL *url  = [NSURL URLWithString:urlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_loginWebview loadRequest:request];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)login:(UIButton*)sender {
    
    sender.userInteractionEnabled = NO;
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    [super keyboardWillShow:notification];
   
    [self.navigationController setNavigationBarHidden:[AppUtils isIphoneVersion:4] || [AppUtils isIphoneVersion:5]  animated:YES];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [super keyboardWillHide:notification];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}


@end
