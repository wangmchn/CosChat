//
//  WKClearBar.m
//  CosChat
//
//  Created by Mark on 15/5/6.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKClearBar.h"

@implementation WKClearBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"Coschat_white"] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
