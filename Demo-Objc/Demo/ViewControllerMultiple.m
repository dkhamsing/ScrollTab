//
//  ViewControllerMultiple.m
//  Demo
//
//  Created by Daniel on 2/6/14.
//
//

#import "ViewControllerMultiple.h"
#import "DKScrollingTabController.h"

@interface ViewControllerMultiple () {
    
}

@end

@implementation ViewControllerMultiple

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Multiple";
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        DKScrollingTabController *leftTabController = [[DKScrollingTabController alloc] init];
        leftTabController.view.tag = 1;
        leftTabController.delegate = self;
        [self addChildViewController:leftTabController];
        [leftTabController didMoveToParentViewController:self];
        [self.view addSubview:leftTabController.view];
        leftTabController.view.frame = CGRectMake(0, 20, 50, 200);
        leftTabController.buttonPadding = 23;
        leftTabController.layoutIsVertical = YES;
        leftTabController.selection = @[@"a", @"b", @"c", @"d", @"e",];
        
        DKScrollingTabController *rightController = [[DKScrollingTabController alloc] init];
        rightController.delegate = self;
        [self addChildViewController:rightController];
        [rightController didMoveToParentViewController:self];
        [self.view addSubview:rightController.view];
        rightController.view.frame = CGRectMake(100, 20, 50, 200);
        rightController.buttonPadding = 23;
        rightController.layoutIsVertical = YES;
        rightController.selection = @[@"zero", @"one", @"two", @"three", @"four",];
    }
    return self;
}


#pragma mark - TabControllerDelegate

- (void)DKScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    NSLog(@"Selection controller %@ action button with index=%@",
          (controller.view.tag==1 ? @"left":@"right"),
          @(selection));
}


@end
