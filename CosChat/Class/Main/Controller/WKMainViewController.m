//
//  WKMainViewController.m
//  CosChat
//
//  Created by zzx🐹 on 15/4/26.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKMainViewController.h"
#import "WKSettingViewController.h"
@interface WKMainViewController ()

@end

@implementation WKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title = @"CosChat";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    [self setUI];
}
/**
 *  跳转设置页面
 */
-(void)setting
{
    WKSettingViewController *set = [[WKSettingViewController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}
/**
 *  界面布局
 */
-(void)setUI
{
    /**
     头像
     */
    UIImageView *head=[[UIImageView alloc]initWithFrame:CGRectMake(10, 150, 100, 100)];
    head.image=[UIImage imageNamed:@"pic"];
    [self.view addSubview:head];
    /**
     角色名
     */
    UILabel *roleName=[[UILabel alloc]initWithFrame:CGRectMake(120, 150, 100, 30)];
    roleName.backgroundColor=[UIColor clearColor];
    roleName.text=@"角色名";
    [self.view addSubview:roleName];
    /**
      角色介绍
     */
    UITextField *introduction=[[UITextField alloc]initWithFrame:CGRectMake(120, 180, 180, 70)];
    introduction.text=@"介绍";
    introduction.backgroundColor=[UIColor redColor];
    [self.view addSubview:introduction];
    /**
     *  标签介绍
     */
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(100, 270, 100, 30)];
    label1.backgroundColor=[UIColor blackColor];
    [self.view addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(100, 320, 100, 30)];
    label2.backgroundColor=[UIColor blackColor];
    [self.view addSubview:label2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(100, 370, 100, 30)];
    label3.backgroundColor=[UIColor blackColor];
    [self.view addSubview:label3];

    UIButton *matchingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    matchingBtn.frame=CGRectMake(50, 420, 200, 50);
    matchingBtn.backgroundColor=[UIColor redColor];
    [matchingBtn setTitle:@"开始匹配" forState:UIControlStateNormal];
    [matchingBtn addTarget:self action:@selector(startMatching:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:matchingBtn];
}
/**
 *  匹配按钮
 */
-(void)startMatching:(UIButton*)button
{
    button.hidden=YES;
    UIView *matchBG=[[UIView alloc]initWithFrame:CGRectMake(0, 410, [UIScreen mainScreen].bounds.size.width, 80)];
    matchBG.backgroundColor=[UIColor greenColor];
    [self.view addSubview:matchBG];
    
    UIImageView *head=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 70, 70)];
    head.image=[UIImage imageNamed:@"pic"];
    [matchBG addSubview:head];
    
    UILabel *roleName=[[UILabel alloc]initWithFrame:CGRectMake(120, 5, 100, 20)];
    roleName.text=@"角色名";
    roleName.backgroundColor=[UIColor clearColor];
    [matchBG addSubview:roleName];
    
    UIButton *startChatting=[UIButton buttonWithType:UIButtonTypeCustom];
    startChatting.frame=CGRectMake(120, 30, 160, 35);
    [startChatting setTitle:@"进入聊天" forState:UIControlStateNormal];
    startChatting.backgroundColor=[UIColor redColor];
    [startChatting addTarget:self action:@selector(joinChatting) forControlEvents:UIControlEventTouchUpInside];
    [matchBG addSubview:startChatting];
}
/**
 *  跳转聊天室
 */
-(void)joinChatting
{
    NSLog(@"进入聊天室");
}
@end
