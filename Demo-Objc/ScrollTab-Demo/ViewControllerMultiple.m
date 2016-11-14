//
//  ViewControllerMultiple.m
//  ScrollTab-Demo
//
//  Created by dkhamsing on 11/9/16.
//  Copyright © 2016 dkhamsing. All rights reserved.
//

#import "ViewControllerMultiple.h"
#import "ScrollTab.h"

@implementation ViewControllerMultiple

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    ScrollTab *tab1;
    {
        ScrollTab *tab = [[ScrollTab alloc] init];
        
        [self.view addSubview:tab];
        tab.translatesAutoresizingMaskIntoConstraints = NO;
        
        ScrollTabConfig *config = [[ScrollTabConfig alloc] init];
        config.items = @[@"zero", @"one", @"two", @"three", @"four", @"five"];
        
        tab.config = config;
        tab.selected = ^(NSString *selection, NSInteger noop) {
            NSLog(@"selected %@", selection);
        };
        
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
        
        tab1 = tab;
    }

    {
        ScrollTab *tab = [[ScrollTab alloc] init];
        
        [self.view addSubview:tab];
        tab.translatesAutoresizingMaskIntoConstraints = NO;
        
        ScrollTabConfig *config = [[ScrollTabConfig alloc] init];
        config.items = @[@"a", @"b", @"c", @"d", @"e"];
        
        tab.config = config;
        tab.index = 2; // set selected tab
        tab.selected = ^(NSString *selection, NSInteger noop) {
            NSLog(@"selected %@", selection);
        };
        
        NSDictionary *views = @{@"tab": tab};
        
        NSDictionary *metrics = @{
                                  @"height": @60,
                                  @"top": @100
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
    
    {
        ScrollTab *tab = [[ScrollTab alloc] init];
        
        [self.view addSubview:tab];
        tab.translatesAutoresizingMaskIntoConstraints = NO;
        
        ScrollTabConfig *config = [[ScrollTabConfig alloc] init];
        config.items = @[@"0", @"1", @"2", @"3", @"4", @"5"];
        config.layoutIsVertical = YES;
        
        tab.selected = ^(NSString *selection, NSInteger noop) {
            NSLog(@"selected %@ and selecting corresponding tab up top", selection);
            tab1.index = selection.integerValue;
        };
        tab.config = config;
        
        NSDictionary *views = @{@"tab": tab};
        
        NSDictionary *metrics = nil;
        
        NSArray *formats = @[
                             @"|[tab(100)]",
                             @"V:|-200-[tab(250)]"
                             ];
        [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:kNilOptions metrics:metrics views:views];
            [self.view addConstraints:constraints];
        }];
    }
}

@end
