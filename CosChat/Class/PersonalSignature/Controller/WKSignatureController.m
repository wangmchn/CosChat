//
//  ViewController.m
//  PersonnalSignature
//
//  Created by zzx🐹 on 15/5/3.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKSignatureController.h"
#import "WKMainViewController.h"
#import "Common.h"
#define WKMargin 2
@interface WKSignatureController ()
@property(nonatomic,strong)NSMutableArray *arrayOfButton;
//@property(nonatomic,strong)NSMutableArray *arrayOfTag;
@end

@implementation WKSignatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个性标签";
    self.arrayOfButton = [NSMutableArray array];
    [self setUI];
}

-(void)setUI
{
    /**
     *  背景
     */
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BGLayer"]];
    /**
     *  已选择
     */
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(16, 75, 125, 30)];
    label.text=@"已选择(至多3个)";
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    /**
     *  标签选择
     */
    int k=0;
    for (int i=0; i<5; i++) {
        for (int j=0; j<2; j++) {
            UIView *tagBG=[[UIView alloc]init];
            tagBG.frame=CGRectMake(j*(159+WKMargin), 150+i*(50+WKMargin), 159, 50);
            tagBG.backgroundColor=[UIColor colorWithRed:0.919 green:1.000 blue:0.960 alpha:0.7];
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.tag=k+2000;
            k++;
            button.frame=CGRectMake(39, 12, 75, 28);
            [button setBackgroundImage:[UIImage imageNamed:@"tag_nor"] forState:UIControlStateNormal];
            button.selected=NO;
            NSString *str=[NSString stringWithFormat:@"%d",k];
            
            [button setTitle:str forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(selectTag:) forControlEvents:UIControlEventTouchUpInside];
            [tagBG addSubview:button];
            [self.view addSubview:tagBG];
        }
    }
    /**
     *  换一批button
     */
    UIButton *change=[UIButton buttonWithType:UIButtonTypeCustom];
    change.frame=CGRectMake(200, 430, 100, 30);
    change.backgroundColor=[UIColor clearColor];
    [change setTitle:@"换一批" forState:UIControlStateNormal];
    [change setTitleColor:kNormalColor forState:UIControlStateNormal];
    [change setTitleColor:kSelectedColor forState:UIControlStateHighlighted];
    [self.view addSubview:change];
    /**
     *  确定按钮
     */
    UIButton *determin=[UIButton buttonWithType:UIButtonTypeCustom];
 
    determin.frame=CGRectMake(35, 495, 250, 35);
    [determin setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
    [determin setBackgroundImage:[UIImage imageNamed:@"next_button_sel"] forState:UIControlStateHighlighted];
    [determin setTitle:@"我就是这样" forState:UIControlStateNormal];
    determin.titleLabel.font=[UIFont systemFontOfSize:18];
    
    [determin addTarget:self action:@selector(determin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determin];
}
- (void)determin{
    WKMainViewController *main = [[WKMainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}
/**
 *  选中后的button
 */
-(void)selectTag:(UIButton*)button
{
    NSInteger count=self.arrayOfButton.count;
    if (count<3&&button.selected==NO)
    {
        button.selected=YES;
        [button setBackgroundImage:[UIImage imageNamed:@"tag_sel"] forState:UIControlStateNormal];
        UIButton *tag=[UIButton buttonWithType:UIButtonTypeCustom];
        tag.tag=1001+count;
        tag.frame=CGRectMake(20+count*105, 105, 75, 28);
        [tag setBackgroundImage:[UIImage imageNamed:@"tag_nor"] forState:UIControlStateNormal];
        NSString *title=button.titleLabel.text;
        [tag setTitle:title forState:UIControlStateNormal];
        [tag addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfButton addObject:tag];
        [self.view addSubview:tag];
    }
    else if(count==3)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"只能选择3个标签" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else if(button.selected==YES)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择其他标签" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }
}
/**
 *  删除button
 */
-(void)deleteTag:(UIButton*)button
{
    for (int i=0; i<10; i++) {
        NSInteger labelTag=2000+i;
        if ([((UIButton*)[self.view viewWithTag:labelTag]).titleLabel.text isEqualToString:button.titleLabel.text]) {
            ((UIButton*)[self.view viewWithTag:labelTag]).selected=NO;
            [((UIButton*)[self.view viewWithTag:labelTag]) setBackgroundImage:[UIImage imageNamed:@"tag_nor"] forState:UIControlStateNormal];
        }
    }
    NSInteger mark=button.tag;
    [self.arrayOfButton removeObject:button];
    [button removeFromSuperview];
    if (mark==1001) {
        for (UIButton *btn in self.arrayOfButton) {
            CGFloat x=btn.frame.origin.x;
            btn.frame=CGRectMake(x-105, 105, 75, 28);
            btn.tag=btn.tag-1;
        }
    }else
    {
        for (UIButton *btn in self.arrayOfButton) {
            if (btn.tag-1000>2) {
                CGFloat x=btn.frame.origin.x;
                btn.frame=CGRectMake(x-105, 105, 75, 28);
                btn.tag=btn.tag-1;
            }
        }
    }

}
@end
