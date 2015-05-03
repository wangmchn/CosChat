//
//  WKRoleIntroduceViewController.m
//  CosChat
//
//  Created by zzx🐹 on 15/4/26.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKRoleIntroduceViewController.h"
#import "WKMainViewController.h"
@interface WKRoleIntroduceViewController ()

@end

@implementation WKRoleIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"角色详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(skip:)];
    [self drawHead];
    [self setRoleName];
    [self setLabel];
    
    
    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    test.backgroundColor = [UIColor redColor];
    test.layer.cornerRadius = 50;
    test.layer.masksToBounds = YES;
    [test addTarget:self action:@selector(makeUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}
- (void)makeUp{
    WKMainViewController *main = [[WKMainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}
- (void)skip:(id)sender{
    
}

-(void)back
{
    
}
/**
 *  头像
 */
-(void)drawHead
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 150, 100, 100)];
    imageView.image=[UIImage imageNamed:@"pic"];
    imageView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:imageView];
}
/**
 *  角色名和介绍
 */
-(void)setRoleName
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(120, 150, 100, 30)];
    label.text=@"杨过";
    label.backgroundColor=[UIColor clearColor];
    [self.view addSubview:label];
    
    UILabel *introduction=[[UILabel alloc]initWithFrame:CGRectMake(120, 180, 180, 70)];
    introduction.backgroundColor=[UIColor blackColor];
    [self.view addSubview:introduction];
}
-(void)setLabel
{
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(100, 300, 100, 30)];
    label1.backgroundColor=[UIColor blackColor];
    [self.view addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(100, 350, 100, 30)];
    label2.backgroundColor=[UIColor blackColor];
    [self.view addSubview:label2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(100, 400, 100, 30)];
    label3.backgroundColor=[UIColor blackColor];
    [self.view addSubview:label3];
}
@end
