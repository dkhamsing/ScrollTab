//
//  ViewControllerVertical.m
//  Demo
//
//  Created by Daniel on 2/6/14.
//
//

#import "ViewControllerVertical.h"
#import "DKScrollingTabController.h"

@interface ViewControllerVertical ()

@end

@implementation ViewControllerVertical

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Vertical";
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        DKScrollingTabController *tabController = [[DKScrollingTabController alloc] init];
        tabController.delegate = self;
        [self addChildViewController:tabController];
        [tabController didMoveToParentViewController:self];
        [self.view addSubview:tabController.view];
        tabController.view.frame = CGRectMake(0, 20, 50, 200);
        tabController.buttonPadding = 23;
        tabController.layoutIsVertical = YES;
        tabController.selection = @[@"zero", @"one", @"two", @"three", @"four",];
    }
    return self;
}


#pragma mark - DKScrollingTabControllerDelegate

- (void)DKScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    NSLog(@"Selection controller action button with index=%d",selection);
}


@end
