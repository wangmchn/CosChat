//
//  WKNavigationController.m
//  CosChat
//
//  Created by Mark on 15/4/29.
//  Copyright (c) 2015年 yq. All rights reserved.
//  27 188 155

#import "WKNavigationController.h"
#define kBarTintColor [UIColor colorWithRed:27.0/255.0 green:188.0/255.0 blue:155.0/255.0 alpha:1.0]
@interface WKNavigationController ()

@end

@implementation WKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
+ (void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = kBarTintColor;
    NSDictionary *attrs = @{
                            NSForegroundColorAttributeName:[UIColor whiteColor]
                            };
    navBar.titleTextAttributes = attrs;
    navBar.tintColor = [UIColor whiteColor];
}
@end
