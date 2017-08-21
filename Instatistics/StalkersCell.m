//
//  StalkersCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "StalkersCell.h"
#import "MainUser.h"
#import "AppUtils.h"


@implementation StalkersCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"StalkersCell";
      self.backgroundColor = [UIColor clearColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 35;
  }
  return self;
}

@end


@implementation StalkersCell



-(NSArray*)stalkers
{
    
    MainUser * mainUser = [MainUser mainUser];
    RLMArray * likes = mainUser.likes;
    
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (IGLiker * liker in likes) {
        
        dict[liker.user.Id] = @{@"user" : liker.user
                                };
        
    }
    
    
    return [dict allValues];
}


- (void)setUpWithSource:(StalkersCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _infoLabel.text = [NSString stringWithFormat:@"Stalkers %d",[self stalkers].count];
    _infoLabel.backgroundColor = [AppUtils collectionViewItemsColor];
    _infoLabel.textColor = [AppUtils collectionViewItemsTitleColor];
}

@end




