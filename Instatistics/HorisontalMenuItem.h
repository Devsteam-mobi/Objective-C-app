//
//  HorisontalMenuItem.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 12/1/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HorisontalMenuItem : NSObject
@property (strong, nonatomic)  NSString *title;
@property (assign, nonatomic)  float currentCount;
@property (assign, nonatomic)  float previousCount;
@property (assign, nonatomic)  float difference;
@property (assign, nonatomic)  BOOL isFloat;
@property (strong, nonatomic)  UIImage *arrowImage;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end
