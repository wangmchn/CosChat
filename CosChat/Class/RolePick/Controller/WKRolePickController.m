//
//  WKRolePickController.m
//  CosChat
//
//  Created by Mark on 15/4/29.
//  Copyright (c) 2015年 yq. All rights reserved.
//  219 213 209

#import "WKRolePickController.h"
#import "WKPageView.h"
#import "WKPageCell.h"
#import "WKRoleInfo.h"
#import "WKRoleView.h"
#import "WKRoleCell.h"
#import "Common.h"
#import "UIColor+Random.h"
#define kCollectionCellIdentifier @"collectionCell"
#define kRoleRate 2.33
#define kNextRate 4.27
#define kNextMargin 39
#define kBlackColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]
#define kMenuColor  [UIColor colorWithRed:219.0/255.0 green:213.0/255.0 blue:209.0/255.0 alpha:1.0]
@interface WKRolePickController () <WKPageViewDataSource,WKPageViewDelegate,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak)   WKPageView *pageView;
@property (nonatomic, weak)   WKRoleView *roleView;
@property (nonatomic, strong) WKRoleInfo *roleInfo;
@property (nonatomic, strong) NSArray *items;
@end

@implementation WKRolePickController
- (NSArray *)items{
    if (_items == nil) {
        _items = @[@"最新",@"言情",@"武侠",@"明星",@"DotA",@"LOL",@"WOW",@"高富帅",@"白富美",@"屌丝",@"壮汉"];
    }
    return _items;
}
- (WKRoleInfo *)roleInfo{
    if (_roleInfo == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"superman" ofType:@"png"];
        _roleInfo = [[WKRoleInfo alloc] initWithName:@"超人" desc:@"神都是自私的，他们穿着红色披风飞来飞去，永远不肯和人类分享他们的神力。" imageURL:path];
    }
    return _roleInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // pre set
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Coschat_white"]];
    
    self.navigationItem.titleView = imageView;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIImage *bgImage = [UIImage imageNamed:@"BGLayer"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    [self setUP];
}
/**
 *  初始化，添加视图
 */
- (void)setUP{
    CGFloat width   = self.view.frame.size.width;
    CGFloat height  = self.view.frame.size.height;
    CGFloat bottomH = width/kNextRate;
    
    // roleView
    CGFloat roleH = width/kRoleRate;
    CGRect roleFrame = CGRectMake(0, 0, width, roleH);
    WKRoleView *roleView = [[WKRoleView alloc] initWithFrame:roleFrame];
    roleView.roleInfo = self.roleInfo;
    [self.view addSubview:roleView];
    self.roleView = roleView;
    // next step
    if (iPhone4s) {
        bottomH = 0;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(nextPressed:)];
    }else{
        CGFloat y = height-58-64;
        CGFloat x = kNextMargin;
        CGFloat nextW = width - x*2;
        CGFloat nextH = 40;
        UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, nextW, nextH)];
        [nextButton setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
        [nextButton setBackgroundImage:[UIImage imageNamed:@"next_button_sel"] forState:UIControlStateHighlighted];
        [nextButton addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
        [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [self.view addSubview:nextButton];
    }
    // pageView
    CGFloat pageY = roleH;
    CGFloat navH = 64;
    CGFloat pageH = height-navH-pageY-bottomH;
    CGRect pageFrame = CGRectMake(0, pageY, width, pageH);
    WKPageView *pageView = [[WKPageView alloc] initWithFrame:pageFrame];
    pageView.dataSource = self;
    pageView.delegate = self;
    [self.view addSubview:pageView];
    self.pageView = pageView;
}
- (void)nextPressed:(id)sender{
    NSLog(@"sender: %@",sender);
}
#pragma mark - Page view dataSource
- (NSUInteger)numbersOfPagesInPageView:(WKPageView *)pageView{
    return self.items.count;
}
- (NSArray *)menuItemsForMenuViewInPageView:(WKPageView *)pageView{
    return self.items;
}
- (WKPageCell *)pageView:(WKPageView *)pageView cellForIndex:(NSInteger)index{
    static NSString *identifier = @"pageCell";
    WKPageCell *cell = [pageView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[WKPageCell alloc] initWithIdentifier:identifier];
        [cell registerClass:[WKRoleCell class] forCellWithReuseIdentifier:kCollectionCellIdentifier];
        cell.delegate = self;
        cell.dataSource = self;
        cell.backgroundColor = [UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1.0];
    }
    return cell;
}
#pragma mark Page view delegate
- (UIColor *)titleColorOfMenuItemInPageView:(WKPageView *)pageView withState:(WKMenuItemTitleColorState)state{
    switch (state) {
        case WKMenuItemTitleColorStateNormal:
            return kBlackColor;
            break;
        case WKMenuItemTitleColorStateSelected:
            return kSelectedColor;
            break;
        default:
            return nil;
            break;
    }
}
- (UIColor *)backgroundColorOfMenuViewInPageView:(WKPageView *)pageView{
    return kMenuColor;
}

#pragma mark - Collection view dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKRoleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
//    cell.roleInfo = self.roleInfo;
    return cell;
}
#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning--------didReceiveMemoryWarning");
}
@end
