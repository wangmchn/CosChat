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
#import "WKSignatureController.h"
#import "Common.h"
#import "UIColor+Random.h"
#define kCollectionCellIdentifier @"collectionCell"
#define kRoleRate 2.33
#define kNextRate 4.27
#define kNextMargin 39
#define kBlackColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]
#define kMenuColor  [UIColor colorWithRed:219.0/255.0 green:213.0/255.0 blue:209.0/255.0 alpha:1.0]
@interface WKRolePickController () <WKPageViewDataSource,WKPageViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak)   WKPageView *pageView;
// 顶部选中角色的详细展示视图
@property (nonatomic, weak)   WKRoleView *roleView;
// 角色信息
@property (nonatomic, strong) WKRoleInfo *roleInfo;
// 记录当前选中的cell路径
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
// 记录当前页面的页号
@property (nonatomic, assign) NSInteger currentPage;
// 记录当前选中cell所在的页号
@property (nonatomic, assign) NSInteger selectedPage;
// 记录选过的角色的页面及路径
// 方便清除由于pageCell复用引起的混乱
@property (nonatomic, strong) NSMutableDictionary *selectedPathes;
//
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *roles;
@end

@implementation WKRolePickController
#pragma mark - lazy load
- (NSIndexPath *)selectedIndexPath{
    if (_selectedIndexPath == nil) {
        _selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    }
    return _selectedIndexPath;
}
- (NSMutableDictionary *)selectedPathes{
    if (_selectedPathes == nil) {
        _selectedPathes = [NSMutableDictionary dictionary];
        [_selectedPathes setObject:self.selectedIndexPath forKey:@(self.selectedPage)];
    }
    return _selectedPathes;
}
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
    if (iPhone4) {
        bottomH = 0;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(nextPressed:)];
    }else{
        CGFloat y = height-65-64;
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
    if (iPhone5) {
        pageH -= 88-bottomH;
    }
    CGRect pageFrame = CGRectMake(0, pageY, width, pageH);
    WKPageView *pageView = [[WKPageView alloc] initWithFrame:pageFrame];
    pageView.dataSource = self;
    pageView.delegate = self;
    [self.view addSubview:pageView];
    self.pageView = pageView;
}
- (void)nextPressed:(id)sender{
    NSLog(@"selectedPage: %ld - selectedIndexpath: %@",(long)self.selectedPage,self.selectedIndexPath);
    
    WKSignatureController *sign = [[WKSignatureController alloc] init];
    [self.navigationController pushViewController:sign animated:YES];
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
    NSLog(@"%ld\n%@",(long)self.selectedPage,self.selectedPathes);
    // 重置每个Page的Cell的选中状态 (由于cell的复用引起)
    if (self.selectedPage != index) {
        NSArray *indexPathes = self.selectedPathes.allValues;
        for (NSIndexPath *indexPath in indexPathes) {
            [cell deselectItemAtIndexPath:indexPath animated:NO];
        }
    }else{
        NSLog(@"%@",self.selectedIndexPath);
        [cell selectItemAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
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
- (void)pageView:(WKPageView *)pageView didChangedPageToIndex:(NSInteger)index{
    self.currentPage = index;
}
- (void)pageView:(WKPageView *)pageView didEndDeceleratingAtPage:(WKPageCell *)pageCell andIndex:(NSInteger)index{
    if (self.selectedPage == index) {
        [pageCell selectItemAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    }
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
    cell.roleInfo = self.roleInfo;
    return cell;
}
#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;
    self.selectedPage = self.currentPage;

    [self.selectedPathes setObject:self.selectedIndexPath forKey:@(self.selectedPage)];
}
@end
