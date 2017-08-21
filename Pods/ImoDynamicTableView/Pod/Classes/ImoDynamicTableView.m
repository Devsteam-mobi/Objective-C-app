//
//  IImoDynamicTableView.m
//  ImoDynamicTableView
//
//  Created by Devsteam.mobi on 12/25/14.
//  Copyright (c) 2014 Imodeveloperlab. All rights reserved.
//

#import "ImoDynamicTableView.h"

@implementation ImoDynamicTableView
@synthesize dynamicTableViewDelegate;

- (instancetype)init
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
  [super awakeFromNib];
  [self setUp];
}

- (void)setUp
{
  offscreenCells = [NSMutableDictionary new];
  self.source = [NSMutableArray new];
  registeredCells = [NSMutableArray new];
  
  self.dataSource = self;
  self.delegate = self;
  self.delaysContentTouches = YES;
  self.canCancelContentTouches = YES;
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
  self.allowsMultipleSelectionDuringEditing = NO;
}

- (void)dealloc {
  
  self.dataSource = nil;
  self.delegate = nil;
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
}

- (void)registerCell:(NSString *)cellClass {
  
  [self registerNib:[UINib nibWithNibName:cellClass bundle:_cellXibsBundle] forCellReuseIdentifier:cellClass];
  [registeredCells addObject:cellClass];
}

- (void)registerClassForObject:(IDDCellSource*)source {
    
    if (![registeredCells containsObject:source.cellClass])
    {
      [self registerNib:[UINib nibWithNibName:source.cellClass bundle:_cellXibsBundle] forCellReuseIdentifier:source.cellClass];
      [registeredCells addObject:source.cellClass];
    }
}

- (void)reloadData {
    
  [super reloadData];
}

- (void)layoutSubviews {
  
  [super layoutSubviews];
}

- (void)layoutIfNeeded {
  
  [super layoutIfNeeded];
  
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  
  [super setEditing:editing animated:animated];
  editingTable = editing;
  
}

- (void)setEditing:(BOOL)editing {
  
  [super setEditing:editing];
  editingTable = editing;
  
}

#pragma mark -  Cell Source
#pragma mark -

- (IDDCellSource*)sourceForIndexPath:(NSIndexPath *)indexPath {
  
  if ([[self.source objectAtIndex:indexPath.section] count] > 0)
  {
    NSMutableArray *array = [self.source objectAtIndex:indexPath.section];
    
    if (array.count >= indexPath.row)
    {
      @try {
        
        id obj = [[self.source objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return obj;
        
      }
      @catch (NSException *exception)
      {
        NSLog(@"%@",exception);
        return nil;
      }
    }
  }
  
  return nil;
}


#pragma mark - Table view data source
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  @try
  {
    return self.source.count;
  }
  @catch (NSException *exception) { NSLog(@"%@",[self.source class]); NSLog(@"%@",exception); }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  @try {
    
    return [[self.source objectAtIndex:section] count];
    
  }
  @catch (NSException *exception) { NSLog(@"%@",exception); }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  @try
  {
    /**
     *  Get object from sections array at index path
     */
    IDDCellSource *source = [self sourceForIndexPath:indexPath];
    
    if (source)
    {
      [self registerClassForObject:source];
      
      /**
       *  Return static cell
       */
      if (source.isStaticCell) { return source.staticCell; }
      
      /**
       *  Prepare and return dynamic cell
       */
      id cell = [tableView dequeueReusableCellWithIdentifier:source.cellClass forIndexPath:indexPath];
      
      ((UITableViewCell*)cell).clipsToBounds = YES;
      [cell setUpWithSource:source];
      
       ((UITableViewCell*)cell).shouldIndentWhileEditing = NO;
      return cell;
    }
    else
    {
      UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
      return cell;
    }
    
  }
  @catch (NSException *exception)
  {
    NSLog(@"%@",exception);
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    return cell;
  }
  
}

#pragma mark - Table View Delegates
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  IDDCellSource *source = [self sourceForIndexPath:indexPath];
  
  if (source)
  {
    /**
     *  Return static height
     */
    if (source.staticHeightForCell > 0.0) { return source.staticHeightForCell; }
    if (source.viewForCell != nil) return source.viewForCell.frame.size.height;
    id cell = nil;
    
    if (source.isStaticCell) {
      
      cell = source.staticCell;
      
    } else {
      
      /**
       *  Dynamic calculate and return height
       */
      [self registerClassForObject:source];
      
      cell = [offscreenCells objectForKey:source.cellClass];
      
      if (!cell)
      {
        cell = [tableView dequeueReusableCellWithIdentifier:source.cellClass];
        [offscreenCells setObject:cell forKey:source.cellClass];
      }
      
    }
    
    ((UITableViewCell*)cell).contentView.frame = CGRectMake(0, 0, 320, 40);
    
    [cell setUpWithSource:source];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    ((UITableViewCell*)cell).bounds = CGRectMake(0.0f,
                                                 0.0f,
                                                 CGRectGetWidth(tableView.bounds),
                                                 CGRectGetHeight(((UITableViewCell*)cell).bounds));
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = [((UITableViewCell*)cell).contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
      source.staticHeightForCell = height + 1;
    return height + 1;
  }
  
  return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  
  IDDCellSource *source = [self sourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
  
  if (source)
  {
    /**
     *  Return static height
     */
    if (source.viewForHeaderInSection != nil)
    {
      if (source.staticHeightForHeaderView > 0.0) { return source.staticHeightForHeaderView; }
      return  source.viewForHeaderInSection.frame.size.height;
    }
    else if (source.staticHeightForHeaderView > 0.0) {
      
      NSLog(@"You need to provide viewForFooterInSection to see the header");
      
    }
  }
  
  return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  
  IDDCellSource *source = [self sourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
  
  if (source)
  {
    /**
     *  Return static height
     */
    if (source.viewForFooterInSection != nil) {
      
      if (source.staticHeightForFooterView > 0.0) { return source.staticHeightForFooterView; }
      return  source.viewForFooterInSection.frame.size.height;
    
    }
    else if (source.staticHeightForFooterView > 0.0) {
      
      NSLog(@"You need to provide viewForFooterInSection to see the footer");
      
    }
  }
  
  return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  
  IDDCellSource *source = [self sourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];

  if (source)
  {
    return source.viewForHeaderInSection;
  }
  return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  
  IDDCellSource *source = [self sourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
  
  if (source)
  {
    return source.viewForFooterInSection;
  }
  return nil;
}


- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  @try
  {
    IDDCellSource *cellSource = [self sourceForIndexPath:indexPath];
    
    if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:didTouchUpInsideRowAtIndexPath:)]) {
      
      [dynamicTableViewDelegate tableView:self
           didTouchUpInsideRowAtIndexPath:indexPath];
    }
    
    if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:didTouchUpInsideCellSource:atIndexPath:)]) {
      
      [dynamicTableViewDelegate tableView:self
               didTouchUpInsideCellSource:cellSource
                              atIndexPath:indexPath];
    }
    
    if (cellSource.radioSelection) { [self updateRadioGroup:cellSource]; }
    if (cellSource.multipleSelection) { [self updateMultipleSelectionGroup:cellSource atIndexPath:indexPath]; }
  
  }
  @catch (NSException *exception) { NSLog(@"%@",exception); }
  
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
    
    [dynamicTableViewDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
  }
  
}


- (void)updateRadioGroup:(IDDCellSource*)cellSource {
  
  NSMutableArray *indexPathArray = [NSMutableArray new];
  
  NSIndexPath *selectedIndexPath = nil;
  IDDCellSource *selectedSource = nil;
  
  NSIndexPath *deselectedIndexPath = nil;
  IDDCellSource *deselectedSource = nil;
  
  for (NSMutableArray *section in self.source) {
    
    for (IDDCellSource *source in section) {
      
      if ([source.groupUID isEqual:cellSource.groupUID])
      {
        BOOL addThisSourceForUpdate = NO;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[section indexOfObject:source]
                                                    inSection:[self.source indexOfObject:section]];
        
        if ([source isEqual:cellSource])
        {
          source.selected = YES;
          addThisSourceForUpdate = YES;

          if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:didSelectSource:atIndexPath:)]) {
            selectedSource = source;
            selectedIndexPath = indexPath;
          }
          
        }
        else if (source.selected) {
          
          source.selected = NO;
          addThisSourceForUpdate = YES;
          
          if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:didDeselectSource:atIndexPath:)]) {
            deselectedSource = source;
            deselectedIndexPath = indexPath;
          }
        }
        
        if (addThisSourceForUpdate) { [indexPathArray addObject:indexPath]; }
      }
    }
  }
  
  [self reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
  
  if (deselectedSource != nil && deselectedIndexPath != nil) {
    
    [dynamicTableViewDelegate tableView:self
                      didDeselectSource:deselectedSource
                            atIndexPath:deselectedIndexPath];
  }
  
  if (selectedSource != nil && selectedIndexPath != nil) {
   
    [dynamicTableViewDelegate tableView:self
                        didSelectSource:selectedSource
                            atIndexPath:selectedIndexPath];
  }

}


- (void)updateMultipleSelectionGroup:(IDDCellSource*)cellSource atIndexPath:(NSIndexPath *)indexPath {
  
  cellSource.selected = !cellSource.selected;
  
  [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  
  if (cellSource.selected)
  {
    if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:didSelectSource:atIndexPath:)])
    {
      [dynamicTableViewDelegate tableView:self
                          didSelectSource:cellSource
                              atIndexPath:indexPath];
    }
    
  } else {
    
    if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:didDeselectSource:atIndexPath:)])
    {
      [dynamicTableViewDelegate tableView:self
                        didDeselectSource:cellSource
                              atIndexPath:indexPath];
    }
  }
  
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
  
  return NO;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  @try
  {
    IDDCellSource *cellSource = [self sourceForIndexPath:indexPath];
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
      [cell setSeparatorInset:cellSource.separatorInsets];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if (cellSource.separatorInsets.left < 1 && cellSource.separatorInsets.right < 1 && [cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
      [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
      [cell setLayoutMargins:cellSource.separatorInsets];
    }
    
  }
  @catch (NSException *exception) { NSLog(@"%@",exception); }
  
}


#pragma mark - Delete Gestesture
#pragma mark -

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  
  IDDCellSource *source = [self sourceForIndexPath:indexPath];

  if (self.editing)
  {
    return source.moveMode;
  }
  else
  {
    return source.deleteMode;
  }
  
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    IDDCellSource *source = [self sourceForIndexPath:indexPath];
    if (source)
    {
      [self deleteCellSource:source withAnimation:UITableViewRowAnimationRight];
    }
  }
}


#pragma mark - Move Gesture
#pragma mark - 

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (self.editing)
  {
     return UITableViewCellEditingStyleNone;
  }
  else
  {
     return UITableViewCellEditingStyleDelete;
  }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 
  IDDCellSource *source = [self sourceForIndexPath:fromIndexPath];
  
  if (source)
  {
    [[self.source objectAtIndex:fromIndexPath.section] removeObjectAtIndex:fromIndexPath.row];
    [[self.source objectAtIndex:toIndexPath.section]  insertObject:source atIndex:toIndexPath.row];
  }

}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
  

  IDDCellSource *source = [self sourceForIndexPath:proposedDestinationIndexPath];
  
  if (source.moveMode) {
    
    return proposedDestinationIndexPath;
    
  }
  
  return sourceIndexPath;
  
}


#pragma mark - Delete
#pragma mark -

- (void)deleteCellSourceAtIndexPath:(NSIndexPath *)indexPath withAnimation:(UITableViewRowAnimation)animation {
  
  [[self.source objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
  [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}


- (void)deleteCellSource:(IDDCellSource*)source withAnimation:(UITableViewRowAnimation)animation {
  
  IDDCellSource *copySource = source;
  NSIndexPath *indexPath = nil;

  for (NSMutableArray *array in self.source)
  {
    for (id obj in array)
    {
      if ([obj isEqual:source])
      {
        indexPath = [NSIndexPath indexPathForRow:[array indexOfObject:obj] inSection:[self.source indexOfObject:array]];
      }
    }
  }
  
  [self deleteCellSourceAtIndexPath:indexPath withAnimation:animation];
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:didDeleteSource:atIndexPath:)])
  {
    [dynamicTableViewDelegate tableView:self didDeleteSource:copySource atIndexPath:indexPath];
  }
}

#pragma mark - Insert
#pragma mark -

- (void)insertCellSource:(IDDCellSource*)cellSource inSection:(NSMutableArray*)sectionArray withAnimation:(UITableViewRowAnimation)animation {
  
  if (cellSource != nil && sectionArray != nil) {
    
    NSMutableArray *indexPathArray = [NSMutableArray new];
    [sectionArray addObject:cellSource];
    
    for (NSMutableArray *section in self.source)
    {
      for (IDDCellSource *source in section)
      {
        if ([source isEqual:cellSource])
        {
          NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[section indexOfObject:source]
                                                      inSection:[self.source indexOfObject:section]];
          [indexPathArray addObject:indexPath];
        }
      }
    }
    
    [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
  }
}

- (void)insertSectionArray:(NSMutableArray*)sectionArray withAnimation:(UITableViewRowAnimation)animation {
  
  [self.source addObject:sectionArray];
  [self insertSections:[NSIndexSet indexSetWithIndex:[self.source indexOfObject:sectionArray]] withRowAnimation:animation];
  
}

#pragma mark - Reload
#pragma mark -

- (void)reloadSectionArray:(NSMutableArray*)sectionArray withAnimation:(UITableViewRowAnimation)animation {
  
  NSLog(@"%@",self.source);
  
  if (((NSArray*)[self.source objectAtIndex:[self.source indexOfObject:sectionArray]]).count == 0) {
    
    @try {
      
      IDDCellSource *source = nil;
      
      if ([sectionArray isKindOfClass:[NSMutableArray class]]) {
        
        source = [IDDCellSource new];
        source.staticHeightForCell = 5;
        source.title = @"";
        [sectionArray addObject:source];
        
      }
      
      if (source != nil) {
        
        [self beginUpdates];
        [self reloadSections:[NSIndexSet indexSetWithIndex:[self.source indexOfObject:sectionArray]] withRowAnimation:animation];
        [self deleteCellSource:source withAnimation:animation];
        [self endUpdates];
        
      } else [self reloadData];
      
    }
    @catch (NSException *exception) { NSLog(@"%@",exception); }
    
  } else {
    
    [self reloadSections:[NSIndexSet indexSetWithIndex:[self.source indexOfObject:sectionArray]] withRowAnimation:animation];
    
  }
  
 
  
}

- (void)reloadCellSource:(IDDCellSource*)cellSource inSection:(NSMutableArray*)sectionArray withAnimation:(UITableViewRowAnimation)animation {
  
  NSMutableArray *indexPathArray = [NSMutableArray new];
  [sectionArray addObject:cellSource];
  
  for (NSMutableArray *section in self.source)
  {
    for (IDDCellSource *source in section)
    {
      if ([source isEqual:cellSource])
      {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[section indexOfObject:source]
                                                    inSection:[self.source indexOfObject:section]];
        [indexPathArray addObject:indexPath];
      }
    }
  }
  
  [self reloadRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
}

#pragma mark - Deq
#pragma mark -

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
  
  [self registerNib:[UINib nibWithNibName:identifier bundle:_cellXibsBundle] forCellReuseIdentifier:identifier];
  [registeredCells addObject:identifier];
  return [super dequeueReusableCellWithIdentifier:identifier];
  
}

#pragma mark - ScrollViewDelegate 
#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
    [dynamicTableViewDelegate scrollViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2) {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
    [dynamicTableViewDelegate scrollViewDidZoom:scrollView];
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
    [dynamicTableViewDelegate scrollViewWillBeginDragging:scrollView];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
    [dynamicTableViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
  }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
    [dynamicTableViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
  }
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
    [dynamicTableViewDelegate scrollViewWillBeginDecelerating:scrollView];
  }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
    [dynamicTableViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
  }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
   return  [dynamicTableViewDelegate viewForZoomingInScrollView:scrollView];
  }
  
  return [UIView new];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view NS_AVAILABLE_IOS(3_2) {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
    [dynamicTableViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
  }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
    [dynamicTableViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
  }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
    return [dynamicTableViewDelegate scrollViewShouldScrollToTop:scrollView];
  }
  
  return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
  
  if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
    [dynamicTableViewDelegate scrollViewDidScrollToTop:scrollView];
  }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
 
    if ([dynamicTableViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [dynamicTableViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
    
}

#pragma mark - Keyboard Notifications
#pragma mark -


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if ([dynamicTableViewDelegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [dynamicTableViewDelegate sectionIndexTitlesForTableView:tableView];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if ([dynamicTableViewDelegate respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [dynamicTableViewDelegate tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return 0;
}

#pragma mark - Keyboard Notifications
#pragma mark -

- (void)keyboardWillShowNotification:(NSNotification *)notification {
  
  if (self.shouldAutoAdjustScroll)
  {
    visibleKeyboardFrame = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardAnimationDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self adjustScrollViewForVisibleKeyboard];
  }
}

- (void)keyboardDidShowNotification:(NSNotification *)notification {
  
  if (self.shouldAutoAdjustScroll)
  {
    visibleKeyboardFrame = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardAnimationDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self adjustScrollViewForVisibleKeyboard];
  }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
  
  if (self.shouldAutoAdjustScroll)
  {
    visibleKeyboardFrame = CGRectZero;
    NSTimeInterval animationDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self revertAutoScrolledViewAnimationDuration:animationDuration];
  }
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
  
  if (self.shouldAutoAdjustScroll)
  {
    visibleKeyboardFrame = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardAnimationDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self adjustScrollViewForVisibleKeyboard];
  }
}

- (void)revertScrollViewInsetsAnimated:(BOOL)animated animationDuration:(NSTimeInterval)animationDuration {
  
  if (scrollViewInsetsWereSaved )
  {
    UIScrollView *scrollView = (UIScrollView *)self;
    
    UIEdgeInsets autoScrolledViewContentInset = autoScrolledViewOriginalContentInset;
    UIEdgeInsets autoScrolledViewScrollIndicatorInsets = autoScrolledViewOriginalScrollIndicatorInsets;
    
    void (^changeInsets)(void) = ^{
      if (! UIEdgeInsetsEqualToEdgeInsets(autoScrolledViewContentInset, scrollView.contentInset)) {
        [scrollView setContentInset:autoScrolledViewContentInset];
      }
      if (! UIEdgeInsetsEqualToEdgeInsets(autoScrolledViewScrollIndicatorInsets, scrollView.scrollIndicatorInsets)) {
        [scrollView setScrollIndicatorInsets:autoScrolledViewScrollIndicatorInsets];
      }
    };
    
    if (animated)
    {
      [UIView animateWithDuration:animationDuration animations:changeInsets];
    }
    else
    {
      changeInsets();
    }
  }
  
  autoScrolledViewOriginalContentInset = UIEdgeInsetsZero;
  autoScrolledViewOriginalScrollIndicatorInsets = UIEdgeInsetsZero;
  scrollViewInsetsWereSaved = NO;
  
}

- (void)revertAutoScrolledViewAnimationDuration:(NSTimeInterval)animationDuration {
  
  [self revertScrollViewInsetsAnimated:(animationDuration > 0.0) animationDuration:animationDuration];
}

- (void)adjustScrollViewForVisibleKeyboard {
  
  UIScrollView *scrollView = (UIScrollView *)self;
  CGRect convertedKeyboardFrame = [[scrollView superview] convertRect:visibleKeyboardFrame fromView:nil];
  CGRect intersectsRect = CGRectIntersection(scrollView.frame, convertedKeyboardFrame);
  
  if (intersectsRect.size.height > 0.0f)
  {
    UIEdgeInsets contentInset;
    UIEdgeInsets scrollIndicatorInsets;
    
    if (scrollViewInsetsWereSaved)
    {
      // Calculate insets from originally saved values
      contentInset = autoScrolledViewOriginalContentInset;
      scrollIndicatorInsets = autoScrolledViewOriginalScrollIndicatorInsets;
    }
    else
    {
      contentInset = scrollView.contentInset;
      scrollIndicatorInsets = scrollView.scrollIndicatorInsets;
      
      autoScrolledViewOriginalContentInset = contentInset;
      autoScrolledViewOriginalScrollIndicatorInsets = scrollIndicatorInsets;
      scrollViewInsetsWereSaved = YES;
    }
    
    contentInset.bottom += intersectsRect.size.height;
    scrollIndicatorInsets.bottom += intersectsRect.size.height;
    
    if (! UIEdgeInsetsEqualToEdgeInsets(scrollView.contentInset, contentInset) || ! UIEdgeInsetsEqualToEdgeInsets(scrollView.scrollIndicatorInsets, scrollIndicatorInsets)) {
      
      void (^insetChanges)(void) = ^{
        scrollView.contentInset = contentInset;
        scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
      };
      
      if (keyboardAnimationDuration > 0.0) {
        [UIView animateWithDuration:keyboardAnimationDuration animations:insetChanges];
      }
      else
      {
        insetChanges();
      }
    }
  }
}


@end
