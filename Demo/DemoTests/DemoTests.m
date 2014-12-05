//
//  DemoTests.m
//  DemoTests
//
//  Created by kewlio on 1/31/14.
//
//

#import <XCTest/XCTest.h>
#import "DKScrollingTabController.h"

@interface DemoTests : XCTestCase
@property (nonatomic, strong) DKScrollingTabController *tabController;
@property (nonatomic) NSInteger numberOfButtons;
@end

@implementation DemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.tabController = [[DKScrollingTabController alloc] init];
    
    NSArray *buttons = @[@"zero", @"one", @"two", @"three", @"four",];
    self.tabController.selection = buttons;

    self.numberOfButtons = buttons.count;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTAssertEqual(TRUE, self.tabController.buttons.count==self.numberOfButtons);
}

@end
