//
//  WKRolePickController.m
//  CosChat
//
//  Created by Mark on 15/4/29.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKRolePickController.h"
#import "WKPersonalSignatureViewController.h"
#import "WKPageView.h"
#import "WKPageCell.h"
#import "UIColor+Random.h"


@interface WKRolePickController () <WKPageViewDataSource,WKPageViewDelegate,UISearchBarDelegate>
@property (nonatomic, weak)   WKPageView *pageView;
@property (nonatomic, strong) NSArray *items;
@end

@implementation WKRolePickController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"角色选择";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.items = @[@"最新",@"言情",@"武侠",@"明星",@"DotA",@"LOL",@"WOW",@"高富帅",@"白富美",@"屌丝",@"壮汉"];
    WKPageView *pageView = [[WKPageView alloc] initWithFrame:self.view.bounds];
    pageView.dataSource = self;
    pageView.delegate = self;
    [self.view addSubview:pageView];
    self.pageView = pageView;

}
#pragma mark - dataSource
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
        UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        [test addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
        test.backgroundColor = [UIColor whiteColor];
        [cell addSubview:test];
    }
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}
- (void)test{
    WKPersonalSignatureViewController *pvc = [[WKPersonalSignatureViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
}
#pragma mark Page view delegate
- (UIColor *)titleColorOfMenuItemInPageView:(WKPageView *)pageView withState:(WKMenuItemTitleColorState)state{
    return [UIColor randomColor];
}
//- (CGFloat)titleSizeOfMenuItemInPageView:(WKPageView *)pageView withState:(WKMenuItemTitleSizeState)state{
//    return 14;
//}
- (UIColor *)backgroundColorOfMenuViewInPageView:(WKPageView *)pageView{
    return nil;
}
@end
