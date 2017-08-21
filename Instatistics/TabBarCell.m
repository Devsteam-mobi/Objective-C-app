//
//  TabBarCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "TabBarCell.h"


@implementation TabBarCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"TabBarCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 44;
  }
  return self;
}

@end


@implementation TabBarCell

- (void)setUpWithSource:(TabBarCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float space = (self.frame.size.width - 5 * 60)/6.0f;
    for (int i = 1; i<= 5; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(space +(space + 60) * (i - 1) , 0, 60, self.frame.size.height);
        NSString * imageName = [NSString stringWithFormat:@"tabBarIcon%d",i];
        if (source.selectedTag == i) {
            imageName = [NSString stringWithFormat:@"tabBarIcon%dSelected",i];
        }
        button.tag = i;
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
        [button addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
}


@end




