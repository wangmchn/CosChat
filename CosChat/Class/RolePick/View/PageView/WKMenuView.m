//
//  WKMenuView.m
//  CosChat
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKMenuView.h"
#import "WKMenuItem.h"
#define kDeflautWidth 65
#define kSearchWidth  0
#define kLMaskWidth   0
#define kRMaskWidth   0
#define kMargin       0
#define kBGColor      [UIColor colorWithRed:172.0/255.0 green:165.0/255.0 blue:162.0/255.0 alpha:1.0];
@interface WKMenuView () <WKMenuItemDelegate>{
    CGFloat _norSize;
    CGFloat _selSize;
    UIColor *_norColor;
    UIColor *_selColor;
}
@property (nonatomic, weak)   UIScrollView *scrollView;
@property (nonatomic, weak)   UIButton *searchButton;
@property (nonatomic, strong) WKMenuItem *selItem;
@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation WKMenuView
#pragma mark - Public Methods
- (instancetype)initWithFrame:(CGRect)frame buttonItems:(NSArray *)items backgroundColor:(UIColor *)bgColor norSize:(CGFloat)norSize selSize:(CGFloat)selSize norColor:(UIColor *)norColor selColor:(UIColor *)selColor{
    if (self = [super initWithFrame:frame]) {
        self.items = items;
        if (bgColor) {
            self.bgColor = bgColor;
        }else{
            self.bgColor = kBGColor;
        }
        self.backgroundColor = self.bgColor;
        _norSize = norSize;
        _selSize = selSize;
        _norColor = norColor;
        _selColor = selColor;
        [self addScrollView];
        [self addItems];
//        [self addSearchButton];
        [self addMask];
    }
    return self;
}
- (void)slideMenuAtProgress:(CGFloat)progress{
    NSInteger tag = (NSInteger)progress + 1;
    CGFloat rate = progress - tag + 1;
    WKMenuItem *currentItem = (WKMenuItem *)[self viewWithTag:tag];
    WKMenuItem *nextItem = (WKMenuItem *)[self viewWithTag:tag+1];
    if (rate == 0.0) {
        rate = 1.0;
        self.selItem = currentItem;
        [self refreshContenOffset];
        return;
    }
    currentItem.rate = 1-rate;
    nextItem.rate = rate;
}
#pragma mark - Private Methods
- (void)refreshContenOffset{
    // 让选中的item位于中间
    CGRect frame = self.selItem.frame;
    CGFloat itemX = frame.origin.x;
    CGFloat width = self.scrollView.frame.size.width;
    CGSize contentSize = self.scrollView.contentSize;
    if (itemX > width/2) {
        CGFloat targetX;
        if ((contentSize.width-itemX) <= width/2) {
            targetX = contentSize.width - width;
        }else{
            targetX = frame.origin.x - width/2 + frame.size.width/2;
        }
        [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
- (void)addScrollView{
    CGFloat width = self.frame.size.width - kSearchWidth - kMargin;
    CGFloat height = self.frame.size.height;
    CGRect frame = CGRectMake(kMargin, 0, width, height);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    CGFloat contentWidth = kDeflautWidth * self.items.count;
    scrollView.contentSize = CGSizeMake(contentWidth, height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
//    scrollView.backgroundColor = self.bgColor;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}
- (void)addItems{
    for (int i = 0; i < self.items.count; i++) {
        CGRect frame = CGRectMake(i*kDeflautWidth, 0, kDeflautWidth, self.frame.size.height);
        WKMenuItem *item = [[WKMenuItem alloc] initWithFrame:frame];
        item.tag = (i+1); // view的默认tag为0，因而要避免设置tag为，紧记!!
        item.title = self.items[i];
        item.delegate = self;
        if (_norSize > 0.0001) {
            item.normalSize = _norSize;
        }
        if ((int)_selSize > 0.0001) {
            item.selectedSize = _selSize;
        }
        if (_norColor) {
            item.normalColor = _norColor;
        }
        if (_selColor) {
            item.selectedColor = _selColor;
        }
        if (i == 0) {
            [item selectedItemWithoutAnimation];
            self.selItem = item;
        }
        [self.scrollView addSubview:item];
    }
}
- (void)addMask{
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    maskLayer.frame = CGRectMake(kMargin, 0, kLMaskWidth, self.frame.size.height);
    NSArray *colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.15].CGColor, (id)[UIColor clearColor].CGColor,nil];
    NSArray *locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:1.0], nil];
    maskLayer.colors = colors;
    maskLayer.locations = locations;
    maskLayer.startPoint = CGPointMake(0, 0);

    maskLayer.endPoint = CGPointMake(1, 0);
    [self.layer addSublayer:maskLayer];
}
//- (void)addSearchButton{
//    CGFloat x = self.frame.size.width - kSearchWidth;
//    CGFloat height = self.frame.size.height;
//    UIButton *search = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, kSearchWidth, height)];
//    search.frame = CGRectMake(x, 0, kSearchWidth, height);
//    search.backgroundColor = self.bgColor;
//    [search setTitle:@"搜" forState:UIControlStateNormal];
//    [search addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self addSubview:search];
//    self.searchButton = search;
//}
#pragma mark - Menu item delegate
- (void)didPressedMenuItem:(WKMenuItem *)menuItem{
    if (self.selItem == menuItem) return;
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelesctedIndex:)]) {
        [self.delegate menuView:self didSelesctedIndex:menuItem.tag-1];
    }
    
    menuItem.selected = YES;
    self.selItem.selected = NO;
    self.selItem = menuItem;
    // 让选中的item位于中间
    [self refreshContenOffset];
}
//- (void)searchClick:(UIButton *)sender{
//    if ([self.delegate respondsToSelector:@selector(menuView:didPressSearchButton:)]) {
//        [self.delegate menuView:self didPressSearchButton:sender];
//    }
//}

@end
