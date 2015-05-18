//
//  WKRoleCell.m
//  CosChat
//
//  Created by Mark on 15/5/4.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKRoleCell.h"
#import "UIImage+Circle.h"
#import "Common.h"

#define kIconWH 79
#define kMargin 10
#define kBGColor [UIColor colorWithRed:242.0/255.0 green:243.0/255.0 blue:242.0/255.0 alpha:0.9]
@implementation WKRoleCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kBGColor;
        
        CGFloat iconY = kMargin;
        if (iPhone6||iPhone6p) {
            iconY = kMargin*2;
        }
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, iconY, kIconWH, kIconWH)];
        CGPoint center = iconView.center;
        center.x = frame.size.width/2;
        iconView.center = center;
        self.icon = iconView;
        [self addSubview:iconView];
        CGFloat y = CGRectGetMaxY(iconView.frame)+kMargin;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, frame.size.width, 15)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:17.0];
        label.textColor = kNormalColor;
        label.tag = 2;
        [self addSubview:label];
    }
    return self;
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    UILabel *label = (UILabel *)[self viewWithTag:2];
    if (selected) {
        label.textColor = [UIColor whiteColor];
        self.backgroundColor = kNormalColor;
    }else{
        label.textColor = kNormalColor;
        self.backgroundColor = kBGColor;
    }
    
}
- (void)setRoleInfo:(WKRoleInfo *)roleInfo{
    __block UIImage *image = [UIImage imageWithContentsOfFile:roleInfo.imageURL];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *icon = [UIImage circleImageWithImage:image borderWidth:kBorderWidth borderColor:kBorderColor];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.icon.image = icon;
        });
    });
    
    UILabel *label = (UILabel *)[self viewWithTag:2];
    label.text = roleInfo.name;
    _roleInfo = roleInfo;
}
@end
