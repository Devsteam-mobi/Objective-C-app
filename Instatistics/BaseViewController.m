//
//  BaseViewController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"
#import <StoreKit/StoreKit.h>
#import "DevsteamRate.h"


@interface BaseViewController ()<SKProductsRequestDelegate, SKPaymentTransactionObserver>
@end

@implementation BaseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _mainUser = [MainUser mainUser];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _mainUser = [MainUser mainUser];
    }
    return self;
}

-(void)logout
{
    [[InstagramAPI sharedInstance] logout];
    [self.navigationController popViewControllerAnimated:YES];
    [[self startPage] performSegueWithIdentifier:segue_showAccountState sender:@(_not_connected)];
}


-(BaseViewController*)startPage
{
    BaseNavigationController * navigationController = (BaseNavigationController*)self.navigationController;
    StartPageViewController * startPage = navigationController.startViewController;
    startPage.mainUser = [[InstagramAPI sharedInstance] loggedInUser];
    return startPage;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationItem.title = @"";
    [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [AppUtils appBackgroundColor];
    _blurView.target = self;
    [_blurView buildInterface];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
        return NO;
    }
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
   // self.navigationItem.title = @"";
    [self removeObservers];
      [self hideLeftMenuView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *leftButtonImage = [UIImage imageNamed:@"back-button-image"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect rect = _blurView.tableView.frame;
    rect.origin.x = - rect.size.width;
    _blurView.tableView.frame = rect;
    _blurView.alpha = 0.0f;
     [self observeKeyboard];
}

-(void)menuButtonPressed:(UIBarButtonItem*)item
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _blurView.alpha = 1.0;
        CGRect rect = _blurView.tableView.frame;
        rect.origin.x = 0;
        _blurView.tableView.frame = rect;
        [self.view layoutIfNeeded];
    }];
    
    
    
    
}

-(IBAction)openUpgradeViewController:(UIButton*)sender
{

    [self.navigationController performSegueWithIdentifier:segue_showUpgradeView sender:nil];

}

-(void)hideLeftMenuView
{
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        _blurView.alpha = 0.0f;
        CGRect rect = _blurView.tableView.frame;
        rect.origin.x = - rect.size.width;
        _blurView.tableView.frame = rect;
        [self.view layoutIfNeeded];
    }];
    
}


- (void)observeKeyboard {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)removeObservers
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
     [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The callback for frame-changing of keyboard
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    self.keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    self.keyboardHeight = keyboardFrame.size.height;
    

}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    self.keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    self.keyboardHeight = keyboardFrame.size.height;
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
   
    
}


-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

- (BOOL)prefersStatusBarHidden
{
    // If self.statusBarHidden is TRUE, return YES. If FALSE, return NO.
    return (self.statusBarHidden) ? YES : NO;
}


-(IBAction)buyItem:(UIButton*)sender
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [Storage setExpirationDate:newDate];
    [self dismissViewControllerAnimated:YES completion:nil];
    return;
    
    if([SKPaymentQueue canMakePayments]){
    
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:UPGRADE_ID_1]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        
        //this is called the user cannot make payments, most likely due to parental controls
    }
    
}

-(IBAction)restorePurchases:(id)sender
{
    [self restore];
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    NSInteger count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        
        request.delegate = self;
        [self purchase:validProduct];
        
    }
    else if(!validProduct){
        
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (void)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction) restore{
    //this is called when the user restores purchases, you should hook this up to a button
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    
    [self paymentQueue:queue updatedTransactions:queue.transactions];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            
                
            case SKPaymentTransactionStateDeferred:
                break;
                
            case SKPaymentTransactionStatePurchasing:
                
                
                
                break;
            case SKPaymentTransactionStatePurchased:
            {
                [self notifySubscribtion:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
            }
                break;
            case SKPaymentTransactionStateRestored:
            {
                
                [self notifySubscribtion:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                NSString *messageString = transaction.error.localizedDescription;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:appErrorDomain message:messageString preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"Retry"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               //[self buyItem:_tempSender];
                                           }];
                
                [alert addAction:okButton];

                [self presentViewController:alert animated:YES completion:nil];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
        }
    }
}


-(void)notifySubscribtion:(SKPaymentTransaction*)transaction
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:transaction.transactionDate options:0];
    [Storage setExpirationDate:newDate];
     [self dismissViewControllerAnimated:YES completion:^{
         [[DevsteamRate sharedInstance] purchased];
     }];
    
}


@end
