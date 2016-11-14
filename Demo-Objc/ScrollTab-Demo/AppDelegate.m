//
//  AppDelegate.m
//  ScrollTab-Demo
//
//  Created by dkhamsing on 11/9/16.
//  Copyright © 2016 dkhamsing. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewControllerFancy.h"
#import "ViewControllerSimple.h"
#import "ViewControllerMultiple.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = ({
        UITabBarController *tabController = [[UITabBarController alloc] init];
        
        NSMutableArray *controllers = [NSMutableArray new];
        
        {
            ViewControllerSimple *c = [[ViewControllerSimple alloc] init];
            c.title = @"Simple";
            [controllers addObject: c];
        }
        
        {
            ViewControllerMultiple *c = [[ViewControllerMultiple alloc] init];
            c.title = @"Multiple";
            [controllers addObject: c];
        }
        
        {
            ViewControllerFancy *c = [[ViewControllerFancy alloc] init];
            c.title = @"Fancy";
            [controllers addObject: c];
        }        
        
        tabController.viewControllers = controllers;
        
        tabController;
    });
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
