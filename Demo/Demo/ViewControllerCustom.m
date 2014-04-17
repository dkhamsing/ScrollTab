//
//  ViewController.m
//  Demo
//
//  Created by dkhamsing on 1/31/14.
//
//

#import "ViewControllerCustom.h"
#import "DKScrollingTabController.h"

@interface ViewControllerCustom () <DKScrollingTabControllerDelegate> {
    DKScrollingTabController *tabController;
}
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation ViewControllerCustom

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Customize";
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 120)];
        [self.view addSubview:self.scrollView];
        NSArray *colors = @[
                            [UIColor redColor],//0
                            [UIColor yellowColor],
                            [UIColor purpleColor],
                            [UIColor greenColor],
                            [UIColor grayColor],
                            ];
        
        [colors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            CGRect frame = CGRectMake(0, 0, self.scrollView.frame.size.width, 100);
            frame.origin.y = 100 * idx;
            UIView *colorView = [[UIImageView alloc] initWithFrame:frame];
            colorView.backgroundColor = obj;
            [self.scrollView addSubview:colorView];
        }];
        self.scrollView.contentSize = CGSizeMake(100,100*colors.count);
        
        tabController = [[DKScrollingTabController alloc] init];
        tabController.delegate = self;
        
        [self addChildViewController:tabController];
        [tabController didMoveToParentViewController:self];
        [self.view addSubview:tabController.view];
        tabController.view.backgroundColor = [UIColor whiteColor];
        tabController.view.frame = CGRectMake(0, 30, 320, 60);
        
        // controller customization
        tabController.selectionFont = [UIFont boldSystemFontOfSize:10];
        tabController.buttonInset = 50;
        tabController.buttonPadding = 10;
        tabController.firstButtonInset = 20;

        tabController.translucent = YES; // experimental, this overrides background colors
        //[tabController addTopBorder:[UIColor grayColor]]; // this might be needed depending on the background view

        CGRect frame = tabController.toolbar.frame;
        frame.size.width = 12000;
        tabController.toolbar.frame = frame;
                
        //remove scroll bar
        tabController.buttonsScrollView.showsHorizontalScrollIndicator = NO;
        
        //add indicator
        tabController.selectedTextColor = [UIColor orangeColor];
        tabController.underlineIndicator = YES; // the color is from selectedTextColor property
        
        //this has to be done after customization
        tabController.selection = @[@"zero", @"one", @"two", @"three", @"four",];

        //example controller using SelectionControllerDelegate
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 100, 50)];
        self.numberLabel.font = [UIFont systemFontOfSize:50];
        self.numberLabel.text = @"0";
        [self.view addSubview:self.numberLabel];
                
        //example button to set selection control button with index 2
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(10, 300, 200, 30);
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"Set button with index 2" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return self;
}


- (void)actionButton {
    [tabController selectButtonWithIndex:2 delegate:YES];
    NSLog(@"Set button with index 2");
}


#pragma mark - TabControllerDelegate

- (void)DKScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    CGPoint scrollPoint = CGPointMake(0, selection*100);
    self.numberLabel.text = [NSString stringWithFormat:@"%d", selection];
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    
    NSLog(@"Selection controller action button with index=%d and scroll point=%@",selection, NSStringFromCGPoint(scrollPoint));
}


@end
