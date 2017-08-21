//
//  PageControllCollectionCell.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "PageControllCollectionCell.h"
#import "AppUtils.h"
#import "AppConstants.h"
#import "SpaceCell.h"
#import "ImageViewCell.h"
#import "SeparatorPaddingCell.h"
#import "FolllowerPorCell.h"
#import "MultiLineStringCell.h"


@implementation PageControllCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.dynamicTableViewDelegate = self;
    self.tableView.scrollEnabled = NO;
}


-(void)setupWithItem:(NSDictionary*)dict
{

    
    NSMutableArray *section = [NSMutableArray new];
    
    
    
    {
        ImageViewCellSource *cellSource = [ImageViewCellSource new];
        cellSource.tag = self.selectedTag;
        if ([AppUtils isIphoneVersion:4]) {
            cellSource.staticHeightForCell = 100;
        }
        [section addObject:cellSource];
        
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 30;
        [section addObject:cellSource];
    }
    
    if (_selectedTag == 0)
    {
        {
            SeparatorPaddingCellSource *cellSource = [SeparatorPaddingCellSource new];
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 25;
            [section addObject:cellSource];
        }
        {
            FolllowerPorCellSource *cellSource = [FolllowerPorCellSource new];
            [section addObject:cellSource];
        }
        {
            
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = dict[@"description"];
            cellSource.staticHeightForCell = 110;
            [section addObject:cellSource];
            
        }
    }
    else
    {
        {
            
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = dict[@"title"];
            cellSource.staticHeightForCell = 45;
            cellSource.font = [UIFont fontWithName:_lato_font_black size:20];
            [section addObject:cellSource];
            
        }
        
        {
            
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = dict[@"description"];
            cellSource.staticHeightForCell = 120.5;
            [section addObject:cellSource];
            
        }
    }

    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];

}



@end
