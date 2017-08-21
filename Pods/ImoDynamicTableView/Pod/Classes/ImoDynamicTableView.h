//
//  IImoDynamicTableView.h
//  ImoDynamicTableView
//
//  Created by Devsteam.mobi on 12/25/14.
//  Copyright (c) 2014 Imodeveloperlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImoDynamicDefaultCell.h"


@class ImoDynamicTableView;

@protocol ImoDynamicTableViewDelegate <NSObject>

@optional

- (void)tableView:(ImoDynamicTableView *)tableView didTouchUpInsideCellSource:(IDDCellSource*)cellSource atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ImoDynamicTableView *)tableView didTouchUpInsideRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ImoDynamicTableView *)tableView didSelectSource:(IDDCellSource*)cellSource atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ImoDynamicTableView *)tableView didDeselectSource:(IDDCellSource*)cellSource atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ImoDynamicTableView *)tableView didDeleteSource:(IDDCellSource*)cellSource atIndexPath:(NSIndexPath *)indexPath;


- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view NS_AVAILABLE_IOS(3_2);
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale;
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end

@interface ImoDynamicTableView : UITableView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate> {
  
  id dynamicTableViewDelegate;
  NSMutableArray *registeredCells;
  NSMutableDictionary *offscreenCells;
  
  CGRect visibleKeyboardFrame;
  double keyboardAnimationDuration;
  BOOL scrollViewInsetsWereSaved;
  
  UIEdgeInsets autoScrolledViewOriginalContentInset;
  UIEdgeInsets autoScrolledViewOriginalScrollIndicatorInsets;
  CGRect autoScrolledViewOriginalFrame;
  
  BOOL editingTable;
  
}

- (void)setUp;

@property (nonatomic,strong) NSMutableArray *source;
@property (nonatomic) id dynamicTableViewDelegate;
@property (nonatomic,assign) BOOL shouldAutoAdjustScroll;
@property (nonatomic,strong) NSBundle *cellXibsBundle;

//insert
- (void)insertCellSource:(IDDCellSource*)cellSource inSection:(NSMutableArray*)sectionArray withAnimation:(UITableViewRowAnimation)animation;
- (void)insertSectionArray:(NSMutableArray*)sectionArray withAnimation:(UITableViewRowAnimation)animation;

//reload
- (void)reloadCellSource:(IDDCellSource*)cellSource inSection:(NSMutableArray*)sectionArray withAnimation:(UITableViewRowAnimation)animation;
- (void)reloadSectionArray:(NSMutableArray*)sectionArray withAnimation:(UITableViewRowAnimation)animation;

//delete
- (void)deleteCellSource:(IDDCellSource*)source withAnimation:(UITableViewRowAnimation)animation;

@end
