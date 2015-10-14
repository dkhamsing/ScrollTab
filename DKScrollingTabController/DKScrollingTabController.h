//
//  DKScrollingTabController.h
//
//  Created by dkhamsing on 1/31/14.
//

#import <UIKit/UIKit.h>


@class DKScrollingTabController;

/** DKScrollingTabController delegate. */
@protocol DKScrollingTabControllerDelegate <NSObject>

/**
 Return index tapped.
 @param controller Controller where tap occured.
 @param selection Index of the selection.
 */
- (void)ScrollingTabController:(DKScrollingTabController*)controller selection:(NSUInteger)selection;


@end


/** A scrolling tab controller alternative to UISegmentedControl. */
@interface DKScrollingTabController : UIViewController

/**
 List of buttons.
 */
@property (nonatomic,strong) NSMutableArray *buttons;


/**
 List of tab options, most of logic in the setter of this property.
 */
@property (nonatomic,strong) NSArray *selection;


/**
 Delegate.
 */
@property (nonatomic,assign) id delegate;


/**
 Scrollview for the buttons.
 */
@property (nonatomic,strong) UIScrollView *buttonsScrollView;


/**
 Button inset. The default inset is 0.
 */
@property (nonatomic,assign) CGFloat buttonInset;


/**
 First button inset. The default inset is 0.
 */
@property (nonatomic,assign) CGFloat firstButtonInset;


/**
 Button padding. The default padding is 0.
 */
@property (nonatomic,assign) CGFloat buttonPadding;


/**
 Button font. The default font is `systemFontOfSize` with size 12.
 */
@property (nonatomic,strong) UIFont *selectionFont;


/**
 Selected state text color. The default color is blue.
 */
@property (nonatomic,strong) UIColor *selectedTextColor;


/**
 Unselected state text color. The default color is gray.
 */
@property (nonatomic,strong) UIColor *unselectedTextColor;


/**
 Selected button background color.
 */
@property (nonatomic,strong) UIColor *selectedBackgroundColor;


/**
 Unselected button background color. The default color is dark gray.
 */
@property (nonatomic,strong) UIColor *unselectedBackgroundColor;


/**
 Selected button background color. The default color is light gray.
 */
@property (nonatomic,assign) BOOL underlineIndicator;



/**
 Color of underline indicator. The default color is blue.
 */
@property (nonatomic,strong) UIColor *underlineIndicatorColor;


/**
 Underline indicator offset. The default offset is 0.
 */
@property (nonatomic,assign) CGFloat underlineIndicatorOffset; 


/**
 Edge insets for the button title. The default is `UIEdgeInsetsZero`.
 */
@property (nonatomic,assign) UIEdgeInsets buttonTitleEdgeInsets;


/**
 Set starting index.
 */
@property (nonatomic, assign) NSInteger startingIndex;


/**
 Number of lines for select control items (buttons)
 */
@property (nonatomic,assign) NSInteger numberOfLines;


/**
 Setting this changes the control layout to be vertical (no scrolling)
 */
@property (nonatomic,assign) BOOL layoutIsVertical;


/**
 Toolbar (experimental).
 */
@property (nonatomic,strong) UIToolbar *toolbar;


/**
 Translucency (experimental).
 */
@property (nonatomic,assign) BOOL translucent;


/**
 Add a top border of 1 pixel (needed to use transluscent option).
 @param color Color of the top border.
 */
- (void)addTopBorder:(UIColor*)color;


/**
 Add a bottom border of 1 pixel.
 @param color Color of the top border.
 */
- (void)addBottomBorder:(UIColor*)color;


/**
 Select a button (the delegate is not called).
 @param index Index of the button.
 */
- (void)selectButtonWithIndex:(NSUInteger)index;


/**
 Select a button and optionally trigger the delegate.
 @param index Index of the button.
 @param delegate Boolean that determines if the delegate is called.
 */
- (void)selectButtonWithIndex:(NSUInteger)index delegate:(BOOL)delegate;


/**
 Unselect all buttons.
 */
- (void)selectNone;


/**
 Set a button title and title label.
 @param attributedString Attributed string of the button.
 @param index Index of the button.
 */
- (void)setButtonAttributedString:(NSAttributedString*)attributedString atIndex:(NSUInteger)index;


/**
 Set a button name.
 @param name Name of the button.
 @param index Index of the button.
 */
- (void)setButtonName:(NSString*)name atIndex:(NSUInteger)index;


@end
