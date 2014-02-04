DKScrollingTabController
============

A Scrolling Tab iOS Control

# Installation
Add the files in the DKScrollingTabController folder to your project.

# Usage

```  objc
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Simple";
        
        self.view.backgroundColor = [UIColor orangeColor];
        
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


- (void)TabControllerSelectionDelegate:(NSUInteger)selection {
    NSLog(@"Selection controller action button tag=%d",selection);
    
}

```

# Demo
DKScrollingTabController includes a sample project in the Demo folder.


# Compatibility
- This project uses ARC.
- This project was tested with iOS 6.1 and iOS 7.

# TODO

- Unit tests


# Say Hi
- [github.com/dkhamsing](https://github.com/dkhamsing)
- [twitter.com/alldonegoodbye](https://twitter.com/alldonegoodbye)
- [contact](http://alldonegoodbye.tumblr.com/ask)

# License
DKScrollingTabController is available under the MIT license. See the [LICENSE](LICENSE) file for more info.