//
//  AccountStateViewController.h
//  Instatistics
//
//  Created by 1 on 07/02/2016.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "BaseViewController.h"

@interface AccountStateViewController : BaseViewController
@property (nonatomic, assign) ConnectionState connectionState;
-(void)buildInterfaceeForState:(ConnectionState)state;
@end
