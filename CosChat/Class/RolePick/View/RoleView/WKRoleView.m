//
//  WKRoleView.m
//  CosChat
//
//  Created by Mark on 15/5/3.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKRoleView.h"
#import "WKImageCache.h"
#import "UIImage+Circle.h"
#import "NSString+filePath.h"
#define kMargin 20
#define kRate 11
#define kIconRate 3.76
#define kAnimateDuration 0.3
@interface WKRoleView (){
    BOOL animate;
}
@end

@implementation WKRoleView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}
// 初始化，添加视图等
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
//    NSString *directoryPath = [NSString cachePathWithFileName:@"Icons"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    UIImage *icon;
//    // 创建文件夹
//    if (![fileManager fileExistsAtPath:directoryPath]) {
//        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    // 看图片是否有缓存
//    NSString *filePath = [directoryPath stringByAppendingPathComponent:[roleInfo.imageURL lastPathComponent]];
//    if (![fileManager fileExistsAtPath:filePath]) {
//        // 没有缓存
//        UIImage *image = [UIImage imageWithContentsOfFile:roleInfo.imageURL];
//        icon = [UIImage circleImageWithImage:image borderWidth:kBorderWidth borderColor:kBorderColor];
//        roleInfo.imageURL = filePath;
//        NSData *data = UIImagePNGRepresentation(icon);
//        [data writeToFile:filePath atomically:YES];
//    }else{
//        // 有缓存
//        icon = [UIImage imageWithContentsOfFile:filePath];
//    }
    WKImageCache *cache = [WKImageCache sharedImageCache];
    [cache downloadImageWithURL:@"http://h.hiphotos.baidu.com/image/pic/item/fc1f4134970a304ef20748f3d3c8a786c9175c96.jpg" completion:^(UIImage *image, NSError *error) {
        NSLog(@"image:%@",image);
    }];
//    self.icon.image = icon;
    self.nameLabel.text = roleInfo.name;
    self.descLabel.text = roleInfo.desc;
}
@end
