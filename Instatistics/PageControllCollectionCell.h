//
//  PageControllCollectionCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImoDynamicTableView/ImoDynamicTableView.h>

@interface PageControllCollectionCell : UICollectionViewCell<ImoDynamicTableViewDelegate>
@property (weak, nonatomic) IBOutlet ImoDynamicTableView *tableView;
@property (nonatomic,assign) NSInteger selectedTag;
@property (nonatomic,strong) id target;


-(void)setupWithItem:(NSString*)imageUrl;
@end
