//
//  ScrollTab.h
//  ScrollTab-Demo
//
//  Created by dkhamsing on 11/9/16.
//  Copyright © 2016 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

/** ScrollTab attributed item, used in ScrollTabConfig for advanced customization of tab items. */
@interface ScrollTabAttributedItem : NSObject

/**
 Convenience initializer.
 @param selected Selected attributed text;
 @param unselected Unselected attributed text;
 */
- (instancetype)initWithSelectedAttributedText:(NSAttributedString *)selected unselectedAttributedText:(NSAttributedString *)unselected;

/**
 Selected attributed text.
 */
@property (nonatomic, strong, readonly) NSAttributedString *selected;

/**
 Unselected attributed text.
 */
@property (nonatomic, strong, readonly) NSAttributedString *unSelected;

@end

/** ScrollTab configuration. */
@interface ScrollTabConfig : NSObject

/**
 List of tab items.
 */
@property (nonatomic, strong) NSArray *items;

#pragma mark Misc

/**
 Whether the tab layout is vertical. Default is `NO` (horizontal).
 */
@property (nonatomic) BOOL layoutIsVertical;

/**
 Whether to show the scroll indicator. Default is `NO`.
 */
@property (nonatomic) BOOL showScrollIndicator;

#pragma mark Customize

/**
 Tab item font.
 */
@property (nonatomic) UIFont *font;

/**
 Tab item pad.
 */
@property (nonatomic) CGFloat itemPad;

/**
 Tab item width.
 */
@property (nonatomic) CGFloat itemWidth;

/**
 Tab item selected text color.
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/**
 Tab item unselected text color.
 */
@property (nonatomic, strong) UIColor *unselectedTextColor;

/**
 Tab item selected background color.
 */
@property (nonatomic, strong) UIColor *selectedBackgroundColor;

/**
 Tab item unselected background color.
 */
@property (nonatomic, strong) UIColor *unselectedBackgroundColor;

#pragma mark Underline indicator

/**
 Whether to show an underline indicator for the selected item.
 */
@property (nonatomic) BOOL showUnderlineIndicator;

/**
 Color of the underline indicator.
 */
@property (nonatomic, strong) UIColor *underlineIndicatorColor;

#pragma mark Advanced control of tab text with attributes

/**
 List of ScrollTabAttributedItems to display, use this instead of `items` for more control on item display.
 */
@property (nonatomic, strong) NSArray <ScrollTabAttributedItem *> *attributedItems;

@end

/** A scrolling tab alternative to UISegmentedControl. */
@interface ScrollTab : UIView

/**
 Set / get current tab index. Initial index is `0`.
 */
@property (nonatomic) NSInteger index;

/**
 Tab ui configuration (a basic default configuration exists).
 */
@property (nonatomic, strong) ScrollTabConfig *config;

/**
 Completion block when a tab is selected.
 @param selected Completion block that takes the selection tab text and index.
 */
@property (nonatomic, copy) void (^selected)(NSString *selection, NSInteger index);

@end
