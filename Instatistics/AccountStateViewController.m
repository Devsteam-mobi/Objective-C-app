//
//  AccountStateViewController.m
//  Instatistics
//
//  Created by 1 on 07/02/2016.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "AccountStateViewController.h"
#import "LoginViewController.h"
#import "HelpAndContactViewController.h"

@interface AccountStateViewController ()


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;
@property (weak, nonatomic) IBOutlet UILabel *connectionLabel;

@end

@implementation AccountStateViewController

- (IBAction)connectOrShowStatistics:(id)sender {
    
    switch (_connectionState) {
        case _connected:
        {
            [self performSegueWithIdentifier:segue_showStatistics sender:nil];
        }
            break;
        case _not_connected:
        {
            [self performSegueWithIdentifier:segue_showLoginView sender:nil];
        }
            break;
            
        default:
            break;
    }

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem new] initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Account";
   
    
    _bottomView.layer.borderColor = [UIColor blackColor].CGColor;
    _bottomView.layer.borderWidth = 0.5;
    _bottomView.clipsToBounds = YES;
    
    _topView.layer.borderColor = [UIColor blackColor].CGColor;
    _topView.layer.borderWidth = 0.5;
    _topView.clipsToBounds = YES;
    
    _connectButton.layer.borderColor = [UIColor blackColor].CGColor;
    _connectButton.layer.borderWidth = 0.5;
    _connectButton.clipsToBounds = YES;
    
    
    _contactButton.layer.borderColor = [UIColor blackColor].CGColor;
    _contactButton.layer.borderWidth = 0.5;
    _contactButton.clipsToBounds = YES;
    
    _connectionLabel.layer.cornerRadius = 5.0f;
    _connectionLabel.clipsToBounds = YES;
    
    [self buildInterfaceeForState:_connectionState];
    // Do any additional setup after loading the view.
}


-(void)buildInterfaceeForState:(ConnectionState)state
{
    _connectionState = state;
    switch (_connectionState) {
        case _connected:
        {
            _connectionLabel.backgroundColor = UIColorFromRGB(0x42972E);
            _connectionLabel.text = @"  connected  ";
            [_connectButton setTitle:@"Report" forState:UIControlStateNormal];
            [_connectButton setTitle:@"Report" forState:UIControlStateSelected];
            [_connectButton setTitle:@"Report" forState:UIControlStateHighlighted];
        }
            break;
        case _not_connected:
        {
            _connectionLabel.backgroundColor = [UIColor lightGrayColor];
            _connectionLabel.text = @"  not connected  ";
            [_connectButton setTitle:@"Connect" forState:UIControlStateNormal];
            [_connectButton setTitle:@"Connect" forState:UIControlStateSelected];
            [_connectButton setTitle:@"Connect" forState:UIControlStateHighlighted];
        }
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:segue_showLoginView]) {
        LoginViewController * login = segue.destinationViewController;
        login.target = self;
    }
    
    if ([segue.destinationViewController isKindOfClass:[HelpAndContactViewController class]]) {
        
        
        HelpAndContactViewController * controller = segue.destinationViewController;
        controller.requestName = [sender tag];
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
