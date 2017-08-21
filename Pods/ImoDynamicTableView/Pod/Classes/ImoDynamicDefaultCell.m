//
//  CTCMolodiojka
//
//  Created by Devsteam.mobi on 9/1/13.
//  Copyright (c) 2013 CTC. All rights reserved.
//

#import "ImoDynamicDefaultCell.h"

#pragma mark - Cell Source
#pragma mark -

@implementation ImoDynamicDefaultCellSource

- (id)init
{
  self = [super init];
  
  if (self)
  {
    self.title = @"ImoDynamicDefaultCell";
    self.cellClass = @"ImoDynamicDefaultCell";
    self.staticHeightForCell = 0;
    self.separatorInsets = UIEdgeInsetsMake(0, 15, 0, 0);
  }
  return self;
}
@end

#pragma mark - Cell Implementation
#pragma mark -

@implementation ImoDynamicDefaultCell

- (id)init
{
    self = [super init];
    if (self)
    {
      [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
   self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self setUp];
}

- (void)setUp {
  
  self.cellView = [[UIView alloc] init];
}


- (void)setUpWithSource:(ImoDynamicDefaultCellSource*)source
{
  for (UIView *view in [self.contentView subviews]) { if (view.tag != 100) {[view removeFromSuperview];}}
  self.contentView.clipsToBounds = NO;
  
  [self layoutIfNeeded];
  [self.contentView addSubview:source.viewForCell];
  
  self.cellTitle.text = source.title;
  
  if (source.target) {
    
    self.cellButton.hidden = NO;
    [self.cellButton addTarget:source.target
                        action:source.selector
              forControlEvents:UIControlEventTouchUpInside];
    
  } else { self.cellButton.hidden = YES; }
  
  
  if (source.selected) {
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(self.frame.size.width - 30, 18, 10, 10);
    [self.contentView addSubview:view];
    
  }
  
}

@end

#pragma mark - Extended Cell Sources
#pragma mark -

@implementation IDDCellSource
@end

#pragma mark - Extended UITableViewCell Implementation
#pragma mark -

@implementation  ImoDynamicDefaultCellExtended

- (void)setUpWithSource:(ImoDynamicDefaultCellSource*)source {
  
}

- (void)layoutSubviews {
  
  [super layoutSubviews];
  for (UIView *view in self.contentView.subviews)
  {
    [view layoutSubviews];
  }
  
}



@end


#pragma mark - Extended Cell Implementation
#pragma mark -

@implementation IDDCell
@end
