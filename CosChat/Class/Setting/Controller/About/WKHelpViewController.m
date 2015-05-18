//
//  WKHelpViewController.m
//  CosChat
//
//  Created by zzx🐹 on 15/5/18.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKHelpViewController.h"
#import "Common.h"
@interface WKHelpViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITextField *backMail;
@property(nonatomic,strong)UITextView *backText;
@property(nonatomic,strong)UILabel *placeholder;
@end

@implementation WKHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.915 alpha:1.000];
    [self setUI];

}
-(void)setUI
{
    self.backMail=[[UITextField alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 45)];
    self.backMail.delegate=self;
    self.backMail.backgroundColor=[UIColor whiteColor];
    self.backMail.placeholder=@"请输入您的QQ或者邮箱地址";
    [self.view addSubview:self.backMail];
    
    self.backText=[[UITextView alloc]initWithFrame:CGRectMake(0, 145, kScreenWidth, 140)];
    self.backText.backgroundColor=[UIColor whiteColor];
    self.backText.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backText.font=[UIFont systemFontOfSize:13];
    //    self.backText.textColor=[UIColor colorWithWhite:0.798 alpha:1.000];
    self.backText.delegate=self;
    [self.view addSubview:self.backText];
    
    self.placeholder=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, 150, 40)];
    //    self.placeholder.enabled=NO;
    self.placeholder.text=@"请提出您的宝贵意见";
    self.placeholder.textColor=[UIColor colorWithWhite:0.798 alpha:1.000];
    self.placeholder.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.placeholder];
    /**
     *  提交按钮
     */
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat nextX = kNextMargin;
    CGFloat nextW = kScreenWidth - 2*nextX;
    CGFloat nextH = kNextHeight;
    CGFloat nextY = self.backText.frame.origin.y+self.backText.frame.size.height+kNextMargin;
    submit.frame = CGRectMake(nextX, nextY, nextW, nextH);
    [submit setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
    [submit setBackgroundImage:[UIImage imageNamed:@"next_button_sel"] forState:UIControlStateHighlighted];
    [submit setTitle:@"提交反馈" forState:UIControlStateNormal];
    
    [submit addTarget:self action:@selector(submitMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    /**
     *  触摸键盘隐藏
     */
    self.view.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
}
-(void)submitMessage:(UIButton*)button
{
    NSLog(@"反馈提交");
}
/**
 *  触摸关闭键盘
 *
 *  @param gestureRecognizer 手势触摸
 */
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

#pragma mark--textview代理
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholder.text=@"";
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        self.placeholder.text=@"请提出您的宝贵意见";
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}
#pragma mark--textfiled代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
