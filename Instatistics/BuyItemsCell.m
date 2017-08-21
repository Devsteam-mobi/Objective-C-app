//
//  BuyItemsCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "BuyItemsCell.h"
#import "AppUtils.h"

@implementation BuyItemsCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"BuyItemsCell";
      self.backgroundColor = [AppUtils blueBackgroundColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 56;
  }
  return self;
}

@end


@implementation BuyItemsCell

- (void)setUpWithSource:(BuyItemsCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    
    _lessLabel.textColor = [AppUtils appBackgroundColor];
    
    _lessLabel.backgroundColor = [AppUtils greenBlueColor];
    _lessLabel.layer.cornerRadius = _lessLabel.frame.size.height/2.0f;
    _lessLabel.clipsToBounds = YES;
    _lessLabel.alpha = source.leesString.length;
    _lessLabel.text = [NSString stringWithFormat:@" %@   ",source.leesString];
    _titlelabel.text = source.title;
    
    _selectButton.tag = source.cellTag;
    [_selectButton removeTarget:source.target action:source.selector forControlEvents:UIControlEventAllEvents];
    [_selectButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
}

@end




