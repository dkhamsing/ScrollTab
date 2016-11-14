//
//  ScrollTab.m
//  ScrollTab-Demo
//
//  Created by dkhamsing on 11/9/16.
//  Copyright © 2016 dkhamsing. All rights reserved.
//

#import "ScrollTab.h"

@implementation ScrollTabAttributedItem

- (instancetype)initWithSelectedAttributedText:(NSAttributedString *)selected unselectedAttributedText:(NSAttributedString *)unselected;
{
    self = [super init];
    if (!self)
        return nil;
    
    _selected = selected;
    _unSelected = unselected;
    
    return self;
}

@end

@implementation ScrollTabConfig

- (instancetype)init;
{
    self = [super init];
    if (!self)
        return nil;
    
    // defaults
    self.font = [UIFont systemFontOfSize:16];
    self.itemWidth = 80.f;
    self.itemPad = 0.f;
    self.selectedTextColor = [UIColor blueColor];
    self.unselectedTextColor = [UIColor darkGrayColor];
    self.selectedBackgroundColor = [UIColor lightGrayColor];
    self.unselectedBackgroundColor = [UIColor grayColor];
    self.underlineIndicatorColor = self.selectedTextColor;
    
    return self;
}

- (void)setAttributedItems:(NSArray *)attributedItems;
{
    _attributedItems = attributedItems;
    
    NSMutableArray *selection = [NSMutableArray new];
    
    for (ScrollTabAttributedItem *attributed in attributedItems)
        [selection addObject:attributed.selected.string];
    
    self.items = selection;
}

@end

@interface ScrollTabCell : UICollectionViewCell

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) ScrollTabConfig *tab;

@property (nonatomic, strong) UIView *underLineView;

@end

@implementation ScrollTabCell

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (!self)
        return nil;
    
    self.button = [[UIButton alloc] init];
    self.underLineView = [[UIView alloc] init];
    
    [self setup];
    
    return self;
}

- (void)setSelected:(BOOL)selected;
{
    [super setSelected:selected];
    [self render];
}

- (void)setTitle:(NSString *)title;
{
    _title = title;
    [self render];
}

- (void)render;
{
    self.button.userInteractionEnabled = NO;
    
    self.button.titleLabel.font = self.tab.font;
    [self.button setTitle:self.title forState:UIControlStateNormal];
    
    self.button.backgroundColor = self.selected ?
        self.tab.selectedBackgroundColor:
        self.tab.unselectedBackgroundColor;
    
    self.underLineView.hidden = ({
        self.tab.showUnderlineIndicator ?
          !self.selected:
          YES;
    });
    
    self.underLineView.backgroundColor = self.tab.underlineIndicatorColor;
    
    UIColor *color = self.selected ?
        self.tab.selectedTextColor:
        self.tab.unselectedTextColor;
    [self.button setTitleColor:color forState:UIControlStateNormal];
}

- (void)setup;
{
    self.button.titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.button];
    [self.button addSubview:self.underLineView];
    
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    self.underLineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{
                            @"tab": self.button,
                            @"line": self.underLineView
                            };
    NSDictionary *metrics = @{@"width":@5};
    
    {
        NSArray *formats = @[
                             @"|[tab]|",
                             @"V:|[tab]|"
                             ];
        [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:kNilOptions metrics:metrics views:views];
            [self addConstraints:constraints];
        }];
    }
    
    {
        NSArray *formats = @[
                             @"|[line]|",
                             @"V:[line(width)]|"
                             ];
        [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:kNilOptions metrics:metrics views:views];
            [self addConstraints:constraints];
        }];
    }
}

@end

@interface ScrollTab () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation ScrollTab

static NSString * const kCollectionViewCellId = @"kCollectionViewCellId";

- (instancetype)init;
{
    self = [super init];
    if (!self)
        return nil;
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    
    [self setup];
    
    return self;
}

- (void)setConfig:(ScrollTabConfig *)config;
{
    _config = config;
    [self render];
}

- (void)setIndex:(NSInteger)index;
{
    _index = index;
    [self render];
    
    if (self.config.items) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

#pragma mark Private

- (void)render;
{
    self.backgroundColor = self.config.unselectedBackgroundColor;
    
    self.layout.minimumLineSpacing = self.config.itemPad;
    self.layout.minimumInteritemSpacing = self.layout.minimumLineSpacing;
    self.layout.scrollDirection = self.config.layoutIsVertical ?
        UICollectionViewScrollDirectionVertical:
        UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.showsHorizontalScrollIndicator = self.config.showScrollIndicator;
    self.collectionView.showsVerticalScrollIndicator = self.collectionView.showsHorizontalScrollIndicator;
    self.collectionView.backgroundColor = self.backgroundColor;
 
    [self.collectionView reloadData];
}

- (void)setup;
{
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[ScrollTabCell class] forCellWithReuseIdentifier:kCollectionViewCellId];
    
    [self addSubview:self.collectionView];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"tab": self.collectionView};
    NSDictionary *metrics = nil;
    NSArray *formats = @[
                         @"|[tab]|",
                         @"V:|[tab]|"
                         ];
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:kNilOptions metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
    
    self.index = 0;
}

#pragma mark Collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.config.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ScrollTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellId forIndexPath:indexPath];
    
    cell.tab = self.config;
    
    cell.selected = indexPath.row == self.index;
    
    if (self.config.attributedItems.count>0) {
        ScrollTabAttributedItem *item = self.config.attributedItems[indexPath.row];
        NSAttributedString *title = cell.selected ?
            item.selected:
            item.unSelected;
        [cell.button setAttributedTitle:title forState:UIControlStateNormal];
    }
    else {
        cell.title = self.config.items[indexPath.row];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{    
    CGSize size = self.config.layoutIsVertical ?
        CGSizeMake(self.bounds.size.width, self.config.itemWidth):
        CGSizeMake(self.config.itemWidth, self.bounds.size.height);
    
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger index = indexPath.row;
    self.index = index;
    
    if (self.selected) {
        NSString *item = self.config.items[index];
        self.selected(item, index);
    }
}

@end
