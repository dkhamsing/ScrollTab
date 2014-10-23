//
//  ViewControllerFancy.m
//  Demo
//
//  Created by Daniel on 4/15/14.
//
//

#import "ViewControllerFancy.h"
#import "DKScrollingTabController.h"

@interface ViewControllerFancy () <DKScrollingTabControllerDelegate>

@end

@implementation ViewControllerFancy

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Fancy";
        
        self.view.backgroundColor = [UIColor lightGrayColor];
        
        DKScrollingTabController *leftTabController = [[DKScrollingTabController alloc] init];
        
        leftTabController.delegate = self;
        [self addChildViewController:leftTabController];
        [leftTabController didMoveToParentViewController:self];
        [self.view addSubview:leftTabController.view];
        leftTabController.view.frame = CGRectMake(0, 20, 320, 40);
 
        leftTabController.view.backgroundColor = [UIColor whiteColor];
        leftTabController.buttonPadding = 10;
        leftTabController.underlineIndicator = YES;
        leftTabController.underlineIndicatorColor = [UIColor redColor];
        leftTabController.buttonsScrollView.showsHorizontalScrollIndicator = NO;
        leftTabController.selectedBackgroundColor = [UIColor clearColor];
        leftTabController.selectedTextColor = [UIColor blackColor];
        leftTabController.unselectedTextColor = [UIColor grayColor];
        leftTabController.unselectedBackgroundColor = [UIColor clearColor];
        leftTabController.startingIndex = 2;
        leftTabController.buttonTitleEdgeInstes = UIEdgeInsetsMake(10, 0, 0, 0);
        
        leftTabController.selection = @[@"PLACE\n0", @"PLACE\n0", @"PLACE\n0", @"PLACE\n0" ];
        [leftTabController setButtonName:@"TWEETS\n400" atIndex:0];
        [leftTabController setButtonName:@"PHOTOS/VIDEOS\n143" atIndex:1];
        [leftTabController setButtonName:@"FOLLOWING\n1,092" atIndex:2];
        [leftTabController setButtonName:@"FOLLOWERS\n924" atIndex:3];

        
        [leftTabController.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton *button = obj;
            button.titleLabel.numberOfLines = 2;
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            NSString *buttonName = button.titleLabel.text;
            NSString *text =  [buttonName substringWithRange: NSMakeRange(0, [buttonName rangeOfString: @"\n"].location)];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:buttonName];
            NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:6] };
            NSRange range = [buttonName rangeOfString:text];
            [attributedString addAttributes:attributes range:range];
            
            button.titleLabel.text = @"";
            [button setAttributedTitle:attributedString forState:UIControlStateNormal];
        }];
    }
    return self;
}


#pragma mark - TabControllerDelegate

- (void)DKScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    NSLog(@"Selection controller action button with index=%d",selection);
    
}


@end
