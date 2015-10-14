DKScrollingTabController
========================

A scrolling tab controller alternative to `UISegmentedControl`.

[![Build Status](https://travis-ci.org/dkhamsing/DKScrollingTabController.svg?branch=master)](https://travis-ci.org/dkhamsing/DKScrollingTabController)
[![Version](https://img.shields.io/cocoapods/v/DKScrollingTabController.svg?style=flat)](https://cocoapods.org/pods/DKScrollingTabController)
[![License](https://img.shields.io/cocoapods/l/DKScrollingTabController.svg?style=flat)](http://cocoadocs.org/docsets/DKScrollingTabController)
[![Platform](https://img.shields.io/cocoapods/p/DKScrollingTabController.svg?style=flat)](http://cocoadocs.org/docsets/DKScrollingTabController)

![](Assets/demo.gif)

# Installation

## Manual
Add the files in the DKScrollingTabController folder to your project.

## [CocoaPods](https://cocoapods.org/)

``` ruby
platform :ios, '7.0'
pod 'DKScrollingTabController'
```

# Usage

## Objective-C

```  objc
#import "DKScrollingTabController.h" 

- (id)init {
    self = [super init];
    if (self) {
        // Add controller as a child view controller (standard view controller containment)
        DKScrollingTabController *tabController = [[DKScrollingTabController alloc] init];
        [self addChildViewController:tabController];
        [tabController didMoveToParentViewController:self];
        [self.view addSubview:tabController.view];
        
        // Customize the tab controller (more options in DKScrollingTabController.h or check the demo)
        tabController.view.frame = CGRectMake(0, 20, 320, 40);
        tabController.buttonPadding = 23;
        tabController.selection = @[@"zero", @"one", @"two", @"three", @"four",];
        
        // Set the delegate (conforms to DKScrollingTabControllerDelegate)
        tabController.delegate = self;
    }
    return self;
}


#pragma mark - DKScrollingTabControllerDelegate

- (void)ScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    NSLog(@"Selection controller action button with index=%@", @(selection));
}

```

## Swift 

``` swift
class ViewController: UIViewController, DKScrollingTabControllerDelegate {

    let tabController = DKScrollingTabController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildViewController(tabController)
        tabController.didMoveToParentViewController(self)
        self.view.addSubview(tabController.view)
        tabController.view.frame = CGRectMake(0, 20, 320, 40)
        tabController.buttonPadding = 25
        tabController.selection = ["zero", "one", "two", "three", "four"]
        tabController.delegate = self
    }
        
    func ScrollingTabController(controller: DKScrollingTabController!, selection: UInt) {
        print("tapped \(selection) \n")
    }

}
```

## Customization
- Change the controller's padding, font, colors and [more](https://github.com/dkhamsing/DKScrollingTabController/blob/master/DKScrollingTabController/DKScrollingTabController.h).
- Set `layoutIsVertical` to YES to show the controller vertically.

# Demo
DKScrollingTabController includes sample projects in the folders Demo-Objc and Demo-Swift.

# Compatibility
This project was tested with iOS 9.

# Contact
- [github.com/dkhamsing](https://github.com/dkhamsing)
- [twitter.com/dkhamsing](https://twitter.com/dkhamsing)

# License
DKScrollingTabController is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
