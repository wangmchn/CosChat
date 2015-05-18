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
#import "NSString+filePath.h"
#import "Common.h"
#define kRoleRate 2.33
#define kNextRate 4.27
#define kGetAllChatters @"chatter/getAllChatters"
#define kBlackColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]
#define kMenuColor  [UIColor colorWithRed:219.0/255.0 green:213.0/255.0 blue:209.0/255.0 alpha:0.7]
@interface WKRolePickController () <WKPageViewDataSource,WKPageViewDelegate>
@property (nonatomic, weak)   WKPageView *pageView;
// 顶部选中角色的详细展示视图
@property (nonatomic, weak)   WKRoleView *roleView;
// 角色信息
@property (nonatomic, strong) WKRoleInfo *roleInfo;
//
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) NSDictionary *rolesValues;
@property (nonatomic, strong) NSDictionary *rolesDict;
@end

@implementation WKRolePickController
#pragma mark - lazy load
// 假数据
- (NSArray *)keys{
    if (_keys == nil) {
        _keys = @[@"最新",@"西游记",@"名著",@"LOL",@"DotA",@"LOL",@"游戏"];
    }
    return _keys;
}
- (NSMutableArray *)values{
    if (_values == nil) {
        _values = [NSMutableArray array];
    }
    return _values;
}
// 假数据
- (WKRoleInfo *)roleInfo{
    if (_roleInfo == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"superman" ofType:@"png"];
        _roleInfo = [[WKRoleInfo alloc] initWithName:@"超人" desc:@"神都是自私的，他们穿着红色披风飞来飞去，永远不肯和人类分享他们的神力。" imageURL:path];
    }
    return _roleInfo;
}
#pragma mark - Private methods
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *filePath = [NSString documentPathWithFileName:@"rolesInfo.plist"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"rolesInfo.plist" ofType:nil];
    self.rolesDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    self.keys = self.rolesDict.allKeys;
    NSArray *array = self.rolesDict.allValues;
    for (NSArray *temp in array) {
        NSMutableArray *item = [NSMutableArray array];
        for (NSDictionary *dict in temp) {
            NSString *name = dict[@"name"];
            NSString *desc = dict[@"content"];
            NSString *imageURL = [[NSBundle mainBundle] pathForResource:@"Chopper" ofType:@"png"];
            WKRoleInfo *roleInfo = [[WKRoleInfo alloc] initWithName:name desc:desc imageURL:imageURL];
            [item addObject:roleInfo];
        }
        [self.values addObject:item];
    }
    
//    NSString *strURL = [NSString stringWithFormat:@"%@%@",kAddress,kGetAllChatters];
//    NSURL *url =[NSURL URLWithString:strURL];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
//    NSString *strBody = [NSString stringWithFormat:@"{\"message\":\"begin\"}"];
//
//    NSData *body = [strBody dataUsingEncoding:NSUTF8StringEncoding];
//
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:body];
//    __weak typeof(self) wself = self;
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        wself.rolesDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        wself.keys = wself.rolesDict.allKeys;
//        wself.values = wself.rolesDict.allValues;
//        if (![wself.keys[0] isEqualToString:@"errorCode"]) {
//            [wself.pageView reloadData];
//            NSString *filePath = [NSString documentPathWithFileName:@"rolesInfo.plist"];
//            [wself.rolesDict writeToFile:filePath atomically:YES];
//        }
//    }];
    
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
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"变身" style:UIBarButtonItemStyleDone target:self action:@selector(nextPressed:)];
    }else{
        CGFloat nextX = kNextMargin;
        CGFloat nextW = width - 2*nextX;
        CGFloat nextH = kNextHeight;
        CGFloat nextY = kNextButtonY - 64;
        UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(nextX, nextY, nextW, nextH)];
        NSLog(@"%@",NSStringFromCGRect(nextButton.frame));
        [nextButton setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
        [nextButton setBackgroundImage:[UIImage imageNamed:@"next_button_sel"] forState:UIControlStateHighlighted];
        [nextButton addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
        [nextButton setTitle:@"变身" forState:UIControlStateNormal];
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
// 变身
- (void)nextPressed:(id)sender{
    // 归档
    NSString *filePath = [NSString documentPathWithFileName:kRoleFileName];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.roleView.roleInfo forKey:kRoleInfoKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
    
    WKSignatureController *sign = [[WKSignatureController alloc] init];
    [self.navigationController pushViewController:sign animated:YES];
}
#pragma mark - Page view dataSource
- (NSUInteger)numbersOfPagesInPageView:(WKPageView *)pageView{
    return self.keys.count;
}
- (NSArray *)menuItemsForMenuViewInPageView:(WKPageView *)pageView{
    return self.keys;
}
- (NSArray *)roleInfosForPageCellInPageView:(WKPageView *)pageView{
    return self.values;
}
- (WKPageCell *)pageView:(WKPageView *)pageView cellForIndex:(NSInteger)index{
    static NSString *identifier = @"pageCell";
    WKPageCell *cell = [pageView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[WKPageCell alloc] initWithIdentifier:identifier];
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
- (void)pageView:(WKPageView *)pageView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath{
    self.roleView.roleInfo = self.values[indexPath.section][indexPath.row];
}
@end
