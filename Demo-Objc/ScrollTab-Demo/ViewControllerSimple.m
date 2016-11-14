//
//  ViewControllerSimple.m
//  ScrollTab-Demo
//
//  Created by dkhamsing on 11/9/16.
//  Copyright © 2016 dkhamsing. All rights reserved.
//

#import "ViewControllerSimple.h"
#import "ScrollTab.h"

@implementation ViewControllerSimple

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    ScrollTab *tab = [[ScrollTab alloc] init];
    
    ScrollTabConfig *config = [[ScrollTabConfig alloc] init];
    config.items = @[@"zero", @"one", @"two", @"three", @"four"];
    
    tab.config = config;
    tab.selected = ^(NSString *selection, NSInteger noop) {
        NSLog(@"selected %@", selection);
    };
    
    // layout
    
    [self.view addSubview:tab];
    tab.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"tab": tab};
    
    NSDictionary *metrics = @{
                              @"height": @60,
                              @"top": @20
                              };
    NSArray *formats = @[
                         @"|[tab]|",
                         @"V:|-top-[tab(height)]"
                         ];
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:kNilOptions metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
}

@end
