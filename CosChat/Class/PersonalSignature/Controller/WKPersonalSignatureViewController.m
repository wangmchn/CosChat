//
//  WKPersonnalSignatureViewController.m
//  CosChat
//
//  Created by zzx🐹 on 15/4/26.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKPersonalSignatureViewController.h"
#import "WKRoleIntroduceViewController.h"
@interface WKPersonalSignatureViewController ()
{
    //三个自己的标签
    UIButton *_label1;
    UIButton *_label2;
    UIButton *_label3;
    //可供选择的标签
    UIButton *_btn1;
    UIButton *_btn2;
    UIButton *_btn3;
    //选择按钮
    UIButton *_selectedButton;
}
@end

@implementation WKPersonalSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"个性标签";
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(skip:)];
 
    [self setLabel];
}
- (void)skip:(id)sender{
    WKRoleIntroduceViewController *roleInfo = [[WKRoleIntroduceViewController alloc] init];
    [self.navigationController pushViewController:roleInfo animated:YES];
}
-(void)finish
{
    WKRoleIntroduceViewController *roleInfo = [[WKRoleIntroduceViewController alloc] init];
    [self.navigationController pushViewController:roleInfo animated:YES];
}

-(void)setLabel
{
    _label1=[UIButton buttonWithType:UIButtonTypeCustom];
    _label1.tag=1;
    _label1.selected=NO;
    _label1.frame =CGRectMake(110, 100, 100, 30);
    _label1.backgroundColor=[UIColor orangeColor];
    [_label1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_label1];
    
    _label2=[UIButton buttonWithType:UIButtonTypeCustom];
    _label2.tag=2;
    _label2.selected=NO;
    _label2.frame=CGRectMake(110, 180, 100, 30);
    _label2.backgroundColor=[UIColor orangeColor];
    [_label2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_label2];
    
    _label3=[UIButton buttonWithType:UIButtonTypeCustom];
    _label3.tag=3;
    _label3.selected=NO;
    _label3.frame=CGRectMake(110, 260, 100, 30);
    _label3.backgroundColor=[UIColor orangeColor];
    [_label3 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_label3];
    
    _btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.frame=CGRectMake(20, 340, 80, 30);
    _btn1.backgroundColor=[UIColor redColor];
    [_btn1 setTitle:@"男的" forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(selectedLabel:) forControlEvents:UIControlEventTouchUpInside];
    [_btn1 addTarget:self action:@selector(selectedLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
    
    _btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.frame=CGRectMake(120, 340, 80, 30);
    _btn2.backgroundColor=[UIColor redColor];
    [_btn2 setTitle:@"女的" forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(selectedLabel:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(selectedLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn2];
    
    _btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn3.frame=CGRectMake(220, 340, 80, 30);
    _btn3.backgroundColor=[UIColor redColor];
    [_btn3 setTitle:@"不知道的" forState:UIControlStateNormal];
    [_btn3 addTarget:self action:@selector(selectedLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn3];
    
    UIButton *change=[UIButton buttonWithType:UIButtonTypeCustom];
    change.frame=CGRectMake(210, 390, 100, 40);
    [change setTitle:@"换一批看看" forState:UIControlStateNormal];
    [self.view addSubview:change];
    
    UIButton *determin=[UIButton buttonWithType:UIButtonTypeCustom];
    determin.frame=CGRectMake(10, 450, 300, 40);
    determin.backgroundColor=[UIColor redColor];
    [determin setTitle:@"我就是这样" forState:UIControlStateNormal];
    [determin addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determin];
    
}
-(void)change:(UIButton*)button
{
    for (UIButton *btn in self.view.subviews) {
        if (btn.tag>0&&btn.tag<4) {
            if (btn.tag!=button.tag) {
                [btn setBackgroundColor:[UIColor orangeColor]];
                btn.selected=NO;
            }
            else
            {
                [btn setBackgroundColor:[UIColor blueColor]];
                btn.selected=YES;
            }
        }

    }
}
-(void)selectedLabel:(UIButton*)button
{
    NSString *str;
    str=button.titleLabel.text;
    NSLog(@"%@",str);
    if (_label1.selected) {
        [_label1 setTitle:str forState:UIControlStateNormal];
    }
    else if (_label2.selected)
    {
        [_label2 setTitle:str forState:UIControlStateNormal];
    }
    else if (_label3.selected)
    {
        [_label3 setTitle:str forState:UIControlStateNormal];
    }
}

@end
