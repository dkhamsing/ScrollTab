//
//  DKScrollingTabController.m
//
//  Created by dkhamsing on 1/31/14.
//

#import "DKScrollingTabController.h"

@interface DKScrollingTabController ()
@property (nonatomic,strong) UIButton *currentButton;
@property (nonatomic,strong) UIView *indicatorView;
@end

@implementation DKScrollingTabController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        [self dk_commonInitialization];
    }
    return self;
}


- (void)setSelection:(NSArray *)selection {
    _selection = selection;
    
    CGRect frame2 = self.view.bounds;
    self.buttonsScrollView.frame = frame2;
    
    if (self.translucent) {
        self.toolbar.frame = frame2;        
        self.view.backgroundColor = [UIColor clearColor];
        _selectedBackgroundColor = [UIColor clearColor];
        _unselectedBackgroundColor = [UIColor clearColor];
    }
    
    // Remove any existing buttons.
    for (UIButton *button in self.buttons)
    {
        [button removeFromSuperview];
    }
    
    self.buttons = [[NSMutableArray alloc] init];
    
    CGFloat inset = _buttonInset;
    
    [selection enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *title = obj ;
        CGRect frame = CGRectZero;
        
        if (_layoutIsVertical) {
            frame.size.width = self.view.frame.size.width;
            frame.size.height = self.view.frame.size.height/_selection.count;
            frame.origin.y = frame.size.height * idx ;            
        }
        else {
            if (idx==0) {
                frame.origin.x = _firstButtonInset;
            }
            else {
                UIButton *previousButton = self.buttons[idx-1];
                frame.origin.x = previousButton.frame.size.width + previousButton.frame.origin.x + inset;
            }
        }

        UIFont *selectionFont;
        if (_selectionFont) {
            selectionFont = _selectionFont;
        }
        else {
            selectionFont = [UIFont systemFontOfSize:12];
        }
        
        if (!_layoutIsVertical) {
            frame.size = [title sizeWithAttributes:  @{NSFontAttributeName: selectionFont} ];
        }
        
        CGFloat padding_vertical = (frame2.size.height - frame.size.height)/2;
        CGFloat padding_horizontal = _buttonPadding;
        if (!_layoutIsVertical) {
            frame.size.width += padding_horizontal*2;
            frame.size.height += padding_vertical*2;
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        //MyLog(@"button %@ = %@",selection[idx], button);
        button.tag = idx;
        button.titleLabel.font = selectionFont;
        button.titleEdgeInsets = self.buttonTitleEdgeInsets;
        
        if (self.numberOfLines>1) {
            button.titleLabel.numberOfLines = self.numberOfLines;
        }
        
        [button setTitle:obj forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dk_actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsScrollView addSubview:button];

        [self.buttons addObject:button];
    }];
        
    UIColor *underlineColor;
    if (_underlineIndicatorColor)
        underlineColor = _underlineIndicatorColor ;
    else
        underlineColor = _selectedTextColor;
     self.indicatorView.backgroundColor = underlineColor;
    [self.buttonsScrollView bringSubviewToFront:self.indicatorView];
    
    if (!_layoutIsVertical && selection.count > 0) {
        UIButton *button = self.buttons[selection.count-1];
        [self.buttonsScrollView setContentSize:CGSizeMake(button.frame.origin.x+button.frame.size.width +_firstButtonInset +inset, frame2.size.height)];
        
        // If scroll view content width is smaller than the view's width, stretch it and distribute space evenly between the buttons
        if (self.buttonsScrollView.contentSize.width < self.view.frame.size.width)
        {
            [self.buttonsScrollView setFrame:CGRectMake(self.buttonsScrollView.frame.origin.x,
                                                        self.buttonsScrollView.frame.origin.y,
                                                        self.view.frame.size.width,
                                                        self.buttonsScrollView.frame.size.height)];
            self.buttonsScrollView.center = self.view.center;
            CGFloat additionalButtonWidth = (self.view.frame.size.width - self.buttonsScrollView.contentSize.width)/[self.buttons count];
            
            for (int i = 0; i < [self.buttons count]; i++) {
                UIButton *button = self.buttons[i];
                button.frame = CGRectMake(button.frame.origin.x + i*additionalButtonWidth, button.frame.origin.y, button.frame.size.width + additionalButtonWidth, button.frame.size.height);
            }
        }

    }
    
    if (self.buttons.count > self.startingIndex)
    {
        [self dk_controlSelect:self.buttons[self.startingIndex]];
    }
}


#pragma mark - Public

- (void)addTopBorder:(UIColor *)color {
    CGRect frame=self.view.bounds;
    frame.origin.y = -1;
    frame.size.height = 1;
    UIView *whiteView = [[UIView alloc] initWithFrame:frame];
    whiteView.backgroundColor = color;
    [self.view addSubview:whiteView];
}

- (void)addBottomBorder:(UIColor*)color {
    CGRect frame=self.view.bounds;
    frame.origin.y = frame.size.height;
    frame.size.height = 1;
    UIView *whiteView = [[UIView alloc] initWithFrame:frame];
    whiteView.backgroundColor = color;
    [self.view addSubview:whiteView];
    
}


- (void)selectButtonWithIndex:(NSUInteger)index {
    [self selectButtonWithIndex:index delegate:NO];
}


- (void)selectButtonWithIndex:(NSUInteger)index delegate:(BOOL)delegate {
    UIButton *button = self.buttons[index];
    [self dk_controlSelect:button];
        
    if (delegate) {
        [_delegate ScrollingTabController:self selection:index];
    }
}


- (void)selectNone {
    UIColor *unselectedColor;
    if (_unselectedTextColor) {
        unselectedColor = _unselectedTextColor;
    }
    else {
        unselectedColor = [UIColor grayColor];
    }
    
    if (_underlineIndicator) {
        _indicatorView.hidden = YES;
    }
    
    UIColor *unselectedBackgroundColor;
    if (_unselectedBackgroundColor) {
        unselectedBackgroundColor = _unselectedBackgroundColor;
    }
    else {
        unselectedBackgroundColor = [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0f];
    }
    
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *enumeratedButtons = (UIButton*) obj ;        
        enumeratedButtons.backgroundColor = unselectedBackgroundColor;
        
        enumeratedButtons.titleLabel.textColor = unselectedColor;
        [enumeratedButtons setTitleColor:unselectedColor forState:UIControlStateNormal];
    }];
}


- (void)setButtonAttributedString:(NSAttributedString*)attributedString atIndex:(NSUInteger)index {
    UIButton *button = self.buttons[index];
    button.titleLabel.attributedText = attributedString;
    [button setTitle:attributedString.string forState:UIControlStateNormal];
}


- (void)setButtonName:(NSString*)name atIndex:(NSUInteger)index {
    UIButton *button = self.buttons[index];
    [button setTitle:name forState:UIControlStateNormal];
    
    //TODO: update layout (in particular, button widths)
}


#pragma mark - Private

- (void)dk_commonInitialization {
    self.toolbar = [[UIToolbar alloc] init];
    [self.view addSubview:self.toolbar];
    
    self.buttonsScrollView = [[UIScrollView alloc] init];
    self.buttonsScrollView.scrollsToTop = NO;
    [self.view addSubview:self.buttonsScrollView];
    
    self.indicatorView = [[UIView alloc] init];
    [self.buttonsScrollView addSubview:self.indicatorView];
    
    self.underlineIndicatorOffset = 0;
    self.startingIndex = 0;
    self.buttonTitleEdgeInsets = UIEdgeInsetsZero;
}


- (void)dk_actionButton:(UIButton*)sender {
    //NSLog(@"Selection controller action button tag=%d",sender.tag);
    [self dk_controlSelect:sender];
    [_delegate ScrollingTabController:self selection:sender.tag];
}


- (void)dk_controlSelect:(UIButton*)button {
    [self selectNone];
    
    if (_underlineIndicator) {
        _indicatorView.hidden = NO;    
    }
    
    UIColor *selectedColor;
    if (_selectedTextColor) {
        selectedColor = _selectedTextColor;
    }
    else {
        selectedColor = [UIColor colorWithRed:0.0f green:0.49f blue:0.96f alpha:1.0f];
    }
    
    UIColor *selectedBackgroundColor;
    if (_selectedBackgroundColor) {
        selectedBackgroundColor = _selectedBackgroundColor;
    }
    else {
        selectedBackgroundColor = [UIColor colorWithRed:0.86f green:0.87f blue:0.87f alpha:1.0f];
    }
    
    button.backgroundColor = selectedBackgroundColor;
    
    button.titleLabel.textColor = selectedColor;
    [button setTitleColor:selectedColor forState:UIControlStateNormal];
    
    CGRect frame = button.frame;
    if (_underlineIndicator) {
        if (self.indicatorView.frame.size.width == 0) {
            CGRect buttonFrame = button.frame;
            buttonFrame.origin.y = frame.size.height - 2 - self.underlineIndicatorOffset;
            buttonFrame.size.height = 2;
            self.indicatorView.frame = buttonFrame;
        }
        else {
            [UIView animateWithDuration:0.3f animations:^{
                CGRect buttonFrame = button.frame;
                buttonFrame.origin.y = frame.size.height - 2 - self.underlineIndicatorOffset;
                buttonFrame.size.height = 2;
                self.indicatorView.frame = buttonFrame;
            }];
        }
    }
    
    CGFloat offset = _buttonInset * 1.5;
    if (offset==0) {
        offset = 30;
    }
    if (button.tag>self.currentButton.tag) {
        frame.origin.x += offset;
    }
    else {
        frame.origin.x -= offset;
    }
    
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
    }
    
    [self.buttonsScrollView scrollRectToVisible:frame animated:YES];
    
    self.currentButton = button;
}


#pragma mark - View Controller

// Enables usage in storyboards.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dk_commonInitialization];
}


@end
