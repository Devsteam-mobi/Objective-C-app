//
//  BaseNavigationController.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/7/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "BaseNavigationController.h"
#import "AppUtils.h"


@interface BaseNavigationController ()

@end

@implementation BaseNavigationController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationBar.barTintColor = [AppUtils appBackgroundColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//  
//    
//}


@end
