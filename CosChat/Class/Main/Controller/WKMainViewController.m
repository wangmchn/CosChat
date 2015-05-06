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
#import "Common.h"
#define kIconRate 2.67
#define kIconYMargin (kScreenHeight/568*172/2)
#define kNameFontSize 25
#define kDescFontSize 15
@interface WKMainViewController ()
@property (nonatomic, strong) WKRoleInfo *roleInfo;
@end

@implementation WKMainViewController
- (WKRoleInfo *)roleInfo{
    if (_roleInfo == nil) {
        NSString *filePath = [NSString stringWithDocumentPath:kRoleFileName];
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        _roleInfo = [unarchiver decodeObjectForKey:kRoleInfoKey];
        [unarchiver finishDecoding];
    }
    return _roleInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BGLayer"]];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Coschat_white"]];
    self.navigationItem.titleView = titleView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Settings"] style:UIBarButtonItemStylePlain target:self action:@selector(setting:)];
    
    [self setUI];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)setUI{
    // 头像
    CGFloat imageWH = kScreenWidth/kIconRate;
    CGFloat imageY = kIconYMargin;
    CGFloat imageX = (kScreenWidth-imageWH)/2;
    CGRect imageFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    imageView.image = [UIImage circleImageWithImage:[UIImage imageWithContentsOfFile:self.roleInfo.imageURL] borderWidth:kBorderWidth borderColor:kBorderColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    // 介绍
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, kScreenHeight*0.38, kScreenWidth*0.38, kScreenHeight*0.07)];
    nameLabel.text = self.roleInfo.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont boldSystemFontOfSize:kNameFontSize];
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UILabel *introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.188, kScreenHeight*0.43, kScreenWidth*0.624, kScreenHeight*0.11)];
    introductionLabel.text = self.roleInfo.desc;
    introductionLabel.numberOfLines = 0;
    introductionLabel.font = [UIFont fontWithName:@"Arial" size:kDescFontSize];
    introductionLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:introductionLabel];
    // 标签
    for (int i=0; i<self.tagArray.count; i++) {
        UIButton *tag=[UIButton buttonWithType:UIButtonTypeCustom];
        tag.frame=CGRectMake(kScreenWidth*0.06+i*kScreenWidth*0.323, kScreenHeight*0.623, kScreenWidth*0.234, kScreenHeight*0.05);
        [tag setBackgroundImage:[UIImage imageNamed:@"tag_nor"] forState:UIControlStateNormal];
        NSString *title=((UIButton*)(self.tagArray[i])).titleLabel.text;
        [tag setTitle:title forState:UIControlStateNormal];
        [self.view addSubview:tag];
    }
    // 匹配按钮
    UIButton *match=[UIButton buttonWithType:UIButtonTypeCustom];
    
    match.frame=CGRectMake(kScreenWidth*0.1, kScreenHeight*0.87, kScreenWidth*0.8, kScreenHeight*0.07);
    [match setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
    [match setBackgroundImage:[UIImage imageNamed:@"next_button_sel"] forState:UIControlStateHighlighted];
    [match setTitle:@"开始匹配" forState:UIControlStateNormal];
    match.titleLabel.font=[UIFont systemFontOfSize:18];
    [match addTarget:self action:@selector(match:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:match];
}
- (void)match:(UIButton *)sender{
//    [self.navigationController popViewControllerAnimated:YES];
    RTSpinKitView *style=[[RTSpinKitView alloc]initWithStyle:RTSpinKitViewStyle9CubeGrid color:[UIColor colorWithRed:1.000 green:0.667 blue:0.442 alpha:1.000]];
    style.frame = CGRectMake(sender.frame.size.width*0.633, sender.frame.size.height/10, 0, 0);
    [sender addSubview:style];
    
}
- (void)setting:(id)sender{
    
    WKSettingViewController *set = [[WKSettingViewController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}
@end
