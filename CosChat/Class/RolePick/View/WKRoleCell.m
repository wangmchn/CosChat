//
//  WKRoleCell.m
//  CosChat
//
//  Created by Mark on 15/5/4.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKRoleCell.h"
#import "UIImage+Circle.h"
#define kIconWH 79
#define kMargin 10

@implementation WKRoleCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kMargin, kIconWH, kIconWH)];
        CGPoint center = iconView.center;
        center.x = frame.size.width/2;
        iconView.center = center;
        iconView.tag = 1;
        [self addSubview:iconView];
        
        NSLog(@"%@",NSStringFromCGRect(frame));
    }
    return self;
}
- (void)setRoleInfo:(WKRoleInfo *)roleInfo{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1];
    UIImage *image = [UIImage imageWithContentsOfFile:roleInfo.imageURL];
    UIImage *icon = [UIImage circleImageWithImage:image borderWidth:kBorderWidth borderColor:kBorderColor];
    imageView.image = icon;
    
    
    _roleInfo = roleInfo;
}
@end
