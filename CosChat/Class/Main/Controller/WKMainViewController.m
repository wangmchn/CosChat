//
//  MainViewController.m
//  PersonnalSignature
//
//  Created by zzx🐹 on 15/5/4.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKMainViewController.h"
#import "WKSettingViewController.h"
#import "WKRoleInfo.h"
#import "NSString+filePath.h"
#import "UIImage+Circle.h"
#import "WKNavigationController.h"
#import "WKMainViewController.h"
#import "RTSpinKitView.h"
#import "WKTagView.h"
#import "WKChatViewController.h"
#import "Common.h"
// icon
#define kIconWH      (kScreenHeight/568*120)
#define kIconYMargin (kScreenHeight/568*86)
// name
#define kNameMargin  (kScreenHeight/568*20)
#define kNameH        (kScreenWidth/320*22)
#define kNameFontSize (kScreenWidth/320*22)
// desc
#define kDescXMargin (kScreenWidth/320*38)
#define kDescYMargin (kScreenHeight/568*25)
#define kDescFontSize (kScreenWidth/320*13.5)
// tag
#define kTagW 74
#define kTagH 30
#define kTagY (kScreenHeight-kScreenHeight/568*213)
#define kTagFontSize 14

#define kSetMargin 30
#define kWKY 35
@interface WKMainViewController ()
@property (nonatomic, strong) WKRoleInfo *roleInfo;
@property (nonatomic, strong) NSArray *titlesArray;
@end

@implementation WKMainViewController
- (WKRoleInfo *)roleInfo{
    if (_roleInfo == nil) {
        NSString *filePath = [NSString documentPathWithFileName:kRoleFileName];
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        _roleInfo = [unarchiver decodeObjectForKey:kRoleInfoKey];
        [unarchiver finishDecoding];
    }
    return _roleInfo;
}
- (NSArray *)titlesArray{
    if (_titlesArray == nil) {
        NSString *filePath = [NSString documentPathWithFileName:kTagFileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            _titlesArray = [NSArray arrayWithContentsOfFile:filePath];
        }else{
            _titlesArray = [NSArray array];
        }
    }
    return _titlesArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BGLayer"]];
    
    [self addTitleBar];
    [self setUI];
}
// 导航栏隐藏，自己添加一个无背景的假导航栏
- (void)addTitleBar{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWKY, 81, 17)];
    imageView.image = [UIImage imageNamed:@"Coschat_green"];
    CGPoint center = imageView.center;
    center.x = self.view.center.x;
    imageView.center = center;
    [self.view addSubview:imageView];
    
    UIButton *rightItem = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kSetMargin, kWKY, 18, 18)];
    [rightItem setImage:[UIImage imageNamed:@"Settings"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightItem];
    UIButton *leftItem = [[UIButton alloc] initWithFrame:CGRectMake(18, kWKY, 40, 18)];
    [leftItem setTitle:@"Back" forState:UIControlStateNormal];
    leftItem.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [leftItem addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftItem];
}
- (void)setting:(id)sender{
    
    WKSettingViewController *set = [[WKSettingViewController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}
- (void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)setUI{
    // 头像
    CGFloat imageWH = kIconWH;
    CGFloat imageY = kIconYMargin;
    CGFloat imageX = (kScreenWidth-imageWH)/2;
    CGRect imageFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    imageView.image = [UIImage circleImageWithImage:[UIImage imageWithContentsOfFile:self.roleInfo.imageURL] borderWidth:kBorderWidth borderColor:kBorderColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    // 名字
    CGFloat nameY = CGRectGetMaxY(imageFrame)+kNameMargin;
    CGFloat nameH = kNameH;
    CGRect nameFrame = CGRectMake(0, nameY, kScreenWidth, nameH);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameFrame];
    nameLabel.text = self.roleInfo.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont boldSystemFontOfSize:kNameFontSize];
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    // 描述
    CGFloat descX = kDescXMargin;
    CGFloat descY = CGRectGetMaxY(nameFrame)+kDescYMargin;
    CGFloat descW = kScreenWidth-2*descX;
    CGFloat descH = 50;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descX, descY, descW, descH)];
    descLabel.text = self.roleInfo.desc;
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:kDescFontSize];
    descLabel.textColor = [UIColor whiteColor];
    [descLabel sizeToFit];
    [self.view addSubview:descLabel];
    
    // 标签
    CGFloat tagGap = (kScreenWidth-2*kDescXMargin-kTagW*3)/2;
    for (int i = 0; i < self.titlesArray.count; i++) {
        WKTagView *tag = [[WKTagView alloc] init];
        tag.frame = CGRectMake(kDescXMargin+i*(tagGap+kTagW), kTagY, kTagW, kTagH);
        [tag setTitle:self.titlesArray[i] forState:UIControlStateNormal];
        tag.userInteractionEnabled = NO;
        [self.view addSubview:tag];
    }
    
    // 匹配按钮
    UIButton *match = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat matchX = kNextMargin;
    CGFloat matchH = kNextHeight;
    CGFloat matchY = kScreenHeight - matchH - kNextBMargin;
    CGFloat matchW = kScreenWidth - 2*matchX;
    match.frame = CGRectMake(matchX, matchY, matchW, matchH);
    [match setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
    [match setBackgroundImage:[UIImage imageNamed:@"next_button_sel"] forState:UIControlStateHighlighted];
    [match setTitle:@"开始匹配" forState:UIControlStateNormal];
    [match addTarget:self action:@selector(match:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:match];
}
- (void)match:(UIButton *)sender{
//    [self.navigationController popViewControllerAnimated:YES];
//    RTSpinKitView *style=[[RTSpinKitView alloc]initWithStyle:RTSpinKitViewStyle9CubeGrid color:[UIColor colorWithRed:1.000 green:0.667 blue:0.442 alpha:1.000]];
//    style.frame = CGRectMake(sender.frame.size.width*0.633, sender.frame.size.height/10, 0, 0);
//    [sender addSubview:style];
    WKChatViewController *chatRoom = [[WKChatViewController alloc] init];
    [self.navigationController pushViewController:chatRoom animated:YES];
}
@end
