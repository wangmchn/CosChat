//
//  WKPopMenuView.m
//  CosChat
//
//  Created by zzx🐹 on 15/5/17.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKPopMenuView.h"
#import "Common.h"
#define kPopMenuHeight 130
@implementation WKPopMenuView
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        self.frame=CGRectMake(0, kScreenHeight-kPopMenuHeight, kScreenWidth, kPopMenuHeight);
        [self addBtn];
    }
    return self;
}

-(void)addBtn
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 10, 40, 20);
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"123" forState:UIControlStateNormal];
    [self addSubview:button];
}
@end
