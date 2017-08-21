//
//  CTCMolodiojka
//
//  Created by Devsteam.mobi on 9/1/13.
//  Copyright (c) 2013 CTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+ImoDynamic.h"

/**
 *  DEFAULT CELL SOURCE
 */

@interface ImoDynamicDefaultCellSource : NSObject

/**
 *  This property contain the string value name of cell class
 */
@property (nonatomic,strong) NSString *cellClass;

/**
 *  If this property is equal to 0 then the tableview will calculate automaticaly the height of cell
 */
@property (nonatomic,assign) float staticHeightForCell;

/**
 *  If the property is equel to 0 the the height of header is geted from frame.size.height of view you gived for viewForHeaderInSection
 */
@property (nonatomic,assign) float staticHeightForHeaderView;

/**
 *  If the property is equel to 0 the the height of foter is geted from frame.size.height of view you gived for viewForFooterInSection
 */
@property (nonatomic,assign) float staticHeightForFooterView;

/**
 *  Use this property to set the view for header in table section, !!!viewForHeaderInSection can be seted only for the first cellSource in curent section
 */
@property (nonatomic,strong) UIView *viewForHeaderInSection;

/**
 *  Use this property to set the view for footer in table section, !!!viewForFooterInSection can be seted only for the first cellSource in curent section
 */
@property (nonatomic,strong) UIView *viewForFooterInSection;

/**
 *  Property to show an custom view in cellView
 */
@property (nonatomic,strong) UIView *viewForCell;


/**
 *  Helper
 */
@property (nonatomic,strong) NSString *title;

/**
 *  Target
 */
@property (nonatomic,strong) id target;

/**
 *  Helper object
 */
@property (nonatomic,strong) id object;

/**
 *  Selector for actions
 */
@property (nonatomic,assign) SEL selector;


/**
 *  Groups
 */
@property (nonatomic,strong) NSString *groupUID;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) BOOL radioSelection;
@property (nonatomic,assign) BOOL multipleSelection;

/**
 *  Delete mode
 */
@property (nonatomic,assign) BOOL deleteMode;
@property (nonatomic,assign) BOOL moveMode;

/*!
 *  adjustableHeight
 */
@property (nonatomic,assign) BOOL adjustableHeight;

/**
 *  isStaticCell
 */
@property (nonatomic,assign) BOOL isStaticCell;

/**
 *  staticCell
 */
@property (nonatomic,strong) id staticCell;


@property (nonatomic,assign) UIEdgeInsets separatorInsets;

@end

/**
 *  DEFAULT CELL SOURCE EXTENDED
 */

@interface IDDCellSource : ImoDynamicDefaultCellSource
@end


/**
 *  DEFAULT CELL
 */

@interface ImoDynamicDefaultCell : UITableViewCell

@property (nonatomic,strong) UIView* cellView;

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;

- (void)setUpWithSource:(ImoDynamicDefaultCellSource*)source;

@end

/**
 *  DEFAULT CELL EXTENDED UITableViewCell
 */

@interface ImoDynamicDefaultCellExtended : UITableViewCell

- (void)setUpWithSource:(ImoDynamicDefaultCellSource*)source;

@end

/**
 *  DEFAULT CELL EXTENDED
 */

@interface IDDCell : ImoDynamicDefaultCell
@end