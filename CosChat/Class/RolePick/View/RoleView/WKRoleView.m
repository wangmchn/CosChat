//
//  WKRoleView.m
//  CosChat
//
//  Created by Mark on 15/5/3.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKRoleView.h"
#import "UIImage+Circle.h"
#define kMargin 20
#define kRate 11
#define kIconRate 3.76
@interface WKRoleView ()
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *descLabel;
@end

@implementation WKRoleView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}
- (void)setUP{
    // 当前选择的角色
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat currentX = width/kRate;
    CGFloat currentY = height/kRate;
    CGFloat currentH = 16;
    CGFloat currentW = 105;
    UILabel *currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentX, currentY, currentW, currentH)];
    currentLabel.text = @"当前选择角色";
    currentLabel.textColor = [UIColor whiteColor];
    currentLabel.font = [UIFont boldSystemFontOfSize:15.0];
    currentLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:currentLabel];
    // icon
    CGFloat iconX = currentX;
    CGFloat iconH = width/kIconRate;
    CGFloat iconW = iconH;
    CGFloat iconY = CGRectGetMaxY(currentLabel.frame)+(self.frame.size.height - CGRectGetMaxY(currentLabel.frame) - iconH)/2.7;
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
    [self addSubview:icon];
    self.icon = icon;
    CGPoint center = currentLabel.center;
    center.x = icon.center.x;
    currentLabel.center = center;
    // name
    CGFloat nameX = CGRectGetMaxX(icon.frame) + currentX/1.43;
    CGFloat nameY = iconY;
    CGFloat nameW = self.frame.size.width - kMargin - nameX;
    CGFloat nameH = 25;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    // desc
    CGFloat descX = nameX;
    CGFloat descY = CGRectGetMaxY(nameLabel.frame)-5;
    CGFloat descW = nameW;
    CGFloat descH = iconH - nameH;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descX, descY, descW, descH)];
    descLabel.font = [UIFont systemFontOfSize:13.0];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.numberOfLines = 0;
    [self addSubview:descLabel];
    self.descLabel = descLabel;
}
- (void)setRoleInfo:(WKRoleInfo *)roleInfo{
    _roleInfo = roleInfo;
    
    UIImage *image = [UIImage imageWithContentsOfFile:roleInfo.imageURL];
    UIImage *icon = [UIImage circleImageWithImage:image borderWidth:kBorderWidth borderColor:kBorderColor];
    self.icon.image = icon;
    self.nameLabel.text = roleInfo.name;
    self.descLabel.text = roleInfo.desc;
}
@end
