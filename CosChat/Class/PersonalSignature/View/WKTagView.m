//
//  WKTagButton.m
//  CosChat
//
//  Created by Mark on 15/5/7.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKTagView.h"

#define kFontSize 14
@implementation WKTagView
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    self.titleLabel.font = [UIFont systemFontOfSize:kFontSize];
    
    [self setBackgroundImage:[UIImage imageNamed:@"tag_nor"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"tag_sel"] forState:UIControlStateHighlighted];
}
@end
