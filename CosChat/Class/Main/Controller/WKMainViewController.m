//
//  MainViewController.m
//  PersonnalSignature
//
//  Created by zzx🐹 on 15/5/4.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKMainViewController.h"
#import "WKSettingViewController.h"
@interface WKMainViewController ()

@end

@implementation WKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI
{
    /**
     *  背景
     */
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BGLayer"]];
    UIImageView *titleView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Coschat_white"]];
    self.navigationItem.titleView = titleView;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Coschat_white"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    self.navigationController.navigationBar.hidden = YES;
    /**
     *  设置按钮
     */
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Settings"] style:UIBarButtonItemStylePlain target:self action:@selector(setting:)];
    /**
     *  头像
     */
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(98, 84, 122, 122)];
    imageView.image=[UIImage imageNamed:@"superman.png"];
    imageView.layer.cornerRadius = 61;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    /**
     *  介绍
     */
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x, 210, 122, 30)];
    nameLabel.text=@"蝙蝠侠";
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:25];
    nameLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UILabel *introductionLabel=[[UILabel alloc]initWithFrame:CGRectMake(37, 270, 246, 45)];
    introductionLabel.text=@"蝙蝠侠蝙蝠侠蝙蝠侠蝙蝠侠蝙蝠侠蝙蝠侠蝙蝠侠";
    introductionLabel.numberOfLines=0;
    introductionLabel.font=[UIFont fontWithName:@"Arial" size:15];
    introductionLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:introductionLabel];
    /**
     *  匹配按钮
     */
    for (int i=0; i<3; i++) {
        UIButton *tag=[UIButton buttonWithType:UIButtonTypeCustom];
        tag.frame=CGRectMake(20+i*105, 350, 75, 28);
        [tag setBackgroundImage:[UIImage imageNamed:@"tag_nor"] forState:UIControlStateNormal];
        NSString *title=[NSString stringWithFormat:@"%d",i];
        [tag setTitle:title forState:UIControlStateNormal];
        [self.view addSubview:tag];
    }
    /**
     *  匹配按钮
     */
    UIButton *match=[UIButton buttonWithType:UIButtonTypeCustom];
    
    match.frame=CGRectMake(35, 495, 250, 35);
    [match setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
    [match setTitle:@"开始匹配" forState:UIControlStateNormal];
    match.titleLabel.font=[UIFont systemFontOfSize:18];
//    [match addTarget:<#(id)#> action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>]
    [self.view addSubview:match];

}
- (void)setting:(id)sender{
    WKSettingViewController *set = [[WKSettingViewController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}
@end
