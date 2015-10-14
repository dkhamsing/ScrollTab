//
//  ViewControllerSimple.m
//  Demo
//
//  Created by Daniel on 2/3/14.
//
//

#import "ViewControllerSimple.h"
#import "DKScrollingTabController.h"

@interface ViewControllerSimple () <DKScrollingTabControllerDelegate>

@end

@implementation ViewControllerSimple

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Simple";
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        DKScrollingTabController *tabController = [[DKScrollingTabController alloc] init];
        tabController.delegate = self;
        [self addChildViewController:tabController];
        [tabController didMoveToParentViewController:self];
        [self.view addSubview:tabController.view];
        tabController.view.frame = CGRectMake(0, 20, 320, 40);
        tabController.buttonPadding = 23;
        tabController.selection = @[@"zero", @"one", @"two", @"three", @"four",];

    }
    return self;
}


#pragma mark - TabControllerDelegate

- (void)ScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    NSLog(@"Selection controller action button with index=%@", @(selection));
    
}


@end
