//
//  WKWelcomeController.m
//  CosChat
//
//  Created by Mark on 15/4/29.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKWelcomeController.h"
#import "WKRolePickController.h"
#import "WKNavigationController.h"
@interface WKWelcomeController ()

@end

@implementation WKWelcomeController
- (void)viewDidLoad{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)changeVC:(UIButton *)sender{
    WKRolePickController *role = [[WKRolePickController alloc] init];
    self.view.window.rootViewController = [[WKNavigationController alloc] initWithRootViewController:role];;
}
@end
