//
//  DKScrollingTabController.h
//
//  Created by dkhamsing on 1/31/14.
//

#import <UIKit/UIKit.h>

@class DKScrollingTabController;
@protocol DKScrollingTabControllerDelegate <NSObject>

/**
 Returns index tapped.
 controller Controller where tap occured.
 selection Index of the selection.
 */
- (void)DKScrollingTabController:(DKScrollingTabController*)controller selection:(NSUInteger)selection;


@end


@interface DKScrollingTabController : UIViewController

@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,strong) NSArray *selection;
@property (nonatomic,assign) id delegate;

// Options to customize the selection controller
@property (nonatomic,strong) UIScrollView *buttonsScrollView;
@property (nonatomic,assign) CGFloat buttonInset;
@property (nonatomic,assign) CGFloat firstButtonInset;
@property (nonatomic,assign) CGFloat buttonPadding;
@property (nonatomic,strong) UIFont *selectionFont;
@property (nonatomic,strong) UIColor *selectedTextColor;
@property (nonatomic,strong) UIColor *unselectedTextColor;
@property (nonatomic,strong) UIColor *selectedBackgroundColor;
@property (nonatomic,strong) UIColor *unselectedBackgroundColor;
@property (nonatomic,assign) BOOL underlineIndicator;
@property (nonatomic,strong) UIColor *underlineIndicatorColor;

// Number of lines for select control items (buttons)
@property (nonatomic,assign) NSInteger numberOfLines;

// Setting this changes the control layout to be vertical (no scrolling)
@property (nonatomic,assign) BOOL layoutIsVertical;

// Experimental
@property (nonatomic,strong) UIToolbar *toolbar;
@property (nonatomic,assign) BOOL translucent;


/**
 Adds a top border of 1 pixel (needed to use transluscent option).
 @param color Color of the top border.
 */
- (void)addTopBorder:(UIColor*)color;

- (void)addBottomBorder:(UIColor*)color;

/**
 Selects a button (the delegate is not called).
 @param index Index of the button.
 */
- (void)selectButtonWithIndex:(NSUInteger)index;


/**
 Selects a button and optionally trigger the delegate.
 @param index Index of the button.
 @param delegate Boolean that determines if the delegate is called.
 */
- (void)selectButtonWithIndex:(NSUInteger)index delegate:(BOOL)delegate;


/**
 Unselects all buttons.
 */
- (void)selectNone;


/**
 Sets a button title and title label.
 @param attributedString Attribuetd string of the button.
 @param index Index of the button.
 */
- (void)setButtonAttributedString:(NSAttributedString*)attributedString atIndex:(NSUInteger)index;


/**
 Sets a button name.
 @param name Name of the button.
 @param index Index of the button.
 */
- (void)setButtonName:(NSString*)name atIndex:(NSUInteger)index;


@end
