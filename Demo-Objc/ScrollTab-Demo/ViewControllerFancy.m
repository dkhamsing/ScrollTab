//
//  ViewControllerFancy.m
//  ScrollTab-Demo
//
//  Created by dkhamsing on 11/9/16.
//  Copyright © 2016 dkhamsing. All rights reserved.
//

#import "ViewControllerFancy.h"
#import "ScrollTab.h"

@implementation ViewControllerFancy

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ScrollTab *tab = [[ScrollTab alloc] init];
    
    ScrollTabConfig *config = [[ScrollTabConfig alloc] init];
    
    UIColor *twitterBlue = [UIColor colorWithRed:0 green:163/255.f blue:238.f alpha:1];

    config.underlineIndicatorColor = twitterBlue;
    config.showUnderlineIndicator = YES;
    config.itemWidth = 83.f;
    config.selectedBackgroundColor = [UIColor whiteColor];
    config.unselectedBackgroundColor = config.selectedBackgroundColor;

    // Configuring attribuetd items is simplified here for the example :)
    NSArray *attributedItems = ({
        NSMutableArray *attributedSelection = ({
            NSMutableArray *attributedSelection = [NSMutableArray new];
            
            UIFont *font = [UIFont boldSystemFontOfSize:20];
            NSDictionary *bottomAttributes = @{
                                               NSFontAttributeName:font,
                                               NSForegroundColorAttributeName:[UIColor blackColor]
                                               };
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"TWEETS" bottom:@"138" bottomAttributes:bottomAttributes];
                [attributedSelection addObject:attributed];
            }
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"FOLLOWING" bottom:@"87" bottomAttributes:bottomAttributes];
                [attributedSelection addObject:attributed];
            }
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"FOLLOWERS" bottom:@"10.2K" bottomAttributes:bottomAttributes];
                [attributedSelection addObject:attributed];
            }
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"LIKES" bottom:@"12" bottomAttributes:bottomAttributes];
                [attributedSelection addObject:attributed];
            }
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"MOMENTS" bottom:@"0" bottomAttributes:bottomAttributes];
                [attributedSelection addObject:attributed];
            }
            
            attributedSelection;
        });
        
        NSArray *attributedUnselection = ({
            NSMutableArray *list = [NSMutableArray new];
            
            UIFont *font = [UIFont boldSystemFontOfSize:20];
            NSDictionary *bottomAttributes = @{
                                               NSFontAttributeName:font,
                                               NSForegroundColorAttributeName:twitterBlue
                                               };
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"TWEETS" bottom:@"138" bottomAttributes:bottomAttributes];
                [list addObject:attributed];
            }
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"FOLLOWING" bottom:@"87" bottomAttributes:bottomAttributes];
                [list addObject:attributed];
            }
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"FOLLOWERS" bottom:@"10.2K" bottomAttributes:bottomAttributes];
                [list addObject:attributed];
            }
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"LIKES" bottom:@"12" bottomAttributes:bottomAttributes];
                [list addObject:attributed];
            }
            
            {
                NSAttributedString *attributed = [self _itemAttributedTextWithTop:@"MOMENTS" bottom:@"0" bottomAttributes:bottomAttributes];
                [list addObject:attributed];
            }
            
            list;
        });
        
        NSMutableArray *list = [NSMutableArray new];
        
        for (NSInteger a=0; a<attributedUnselection.count; a++)
        {
            NSAttributedString  *selected = attributedSelection[a];
            NSAttributedString *unSelected = attributedUnselection[a];
            
            ScrollTabAttributedItem *i = [[ScrollTabAttributedItem alloc] initWithSelectedAttributedText:selected unselectedAttributedText:unSelected];
            
            [list addObject:i];
        }
        
        list;
    });    
    config.attributedItems = attributedItems;
    
    tab.config = config;
    tab.backgroundColor = config.selectedBackgroundColor;
    tab.selected = ^(NSString *noop, NSInteger index) {
        NSLog(@"selected tab with index %@", @(index));
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

#pragma mark Helper

- (NSAttributedString *)_itemAttributedTextWithTop:(NSString *)top bottom:(NSString *)bottom bottomAttributes:(NSDictionary *)bottomAttributes;
{
    NSString *string = [NSString stringWithFormat:@"%@\n%@", top, bottom];
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:style,
                                 NSFontAttributeName:[UIFont systemFontOfSize:10],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    
    {
        NSRange range = [string rangeOfString:bottom];
        [attributed addAttributes:bottomAttributes range:range];
    }
    
    return attributed;
}

@end
