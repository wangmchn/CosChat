//
//  ViewController.m
//  PersonnalSignature
//
//  Created by zzx🐹 on 15/5/3.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKSignatureController.h"
#import "WKMainViewController.h"
#import "NSString+filePath.h"
#import "Common.h"
#import "WKButtonData.h"
#define WKMargin 2
#define kAnimateInterval 0.3
@interface WKSignatureController ()
{
    WKButtonData *_titleArray;
}

@property(nonatomic,strong) WKButtonData *data;
@property(nonatomic,strong) NSMutableArray *arrayOfButton;
@property(nonatomic,strong) NSMutableArray *arrayOfTitle;
//@property(nonatomic,strong)NSMutableArray *arrayOfTag;
@end

@implementation WKSignatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个性标签";
    self.arrayOfButton = [NSMutableArray array];
    [self getButtonData];
    [self setUI];
}
-(void)setData:(WKButtonData *)data
{
    _data=data;
    _arrayOfTitle=data.buttonTitleArray;
}
/**
 *  获取标签数据
 */
- (void)getButtonData
{
    NSMutableArray *array=[NSMutableArray arrayWithObjects:@"我的",@"好的",@"他的",@"你的",@"进来",@"发饿",@"啊今",@"飞啊服务",@"无法",@"不是",@"网盘",@"额头",@"请我",@"容易",@"知道",@"放弃",@"垃圾",@"安妮",@"我是",@"秋游",@"百度",@"手机",@"大家", nil];
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:array];
    NSUInteger k=self.arrayOfButton.count;
    NSMutableArray *title=[NSMutableArray array];
    for (int i=0; i<k; i++) {
        [title addObject:((UIButton*)[self.view viewWithTag:1001+i]).titleLabel.text];
    }
    
    for (int j=0;j<tempArray.count;j++) {
        for (int i=0; i<k; i++) {
            if ([tempArray[j] isEqualToString:title[i]]) {
                [tempArray removeObject:tempArray[j]];
            }
        }
    }
    NSMutableArray *name=[NSMutableArray array];
    for (int i=0; i<10; i++) {
        int k=arc4random()%tempArray.count;
        name[i]=tempArray[k];
        [tempArray removeObject:tempArray[k]];
    }
    _titleArray = [[WKButtonData alloc] initWithButtonTitle:name];
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
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.05, kScreenHeight*0.12, 125, 30)];
    label.text=@"已选择(至多3个)";
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    /**
     *  标签选择
     */
    int k=0;

    self.data=_titleArray;
    for (int i=0; i<5&&k<10; i++) {
        for (int j=0; j<2; j++) {
            UIView *tagBG=[[UIView alloc]init];
            tagBG.frame=CGRectMake(j*(kScreenWidth/2-1+WKMargin), kScreenHeight*0.264+i*(kScreenHeight*0.09+WKMargin), kScreenWidth/2, kScreenHeight*0.09);
            tagBG.backgroundColor=[UIColor colorWithRed:0.919 green:1.000 blue:0.960 alpha:0.7];
            /**
             *  按钮button:tag从2000到2009
             */
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.tag=k+2000;

            button.frame=CGRectMake(tagBG.frame.size.width*0.25, tagBG.frame.size.height*0.24, tagBG.frame.size.width*0.47, tagBG.frame.size.height*0.58);
            [button setBackgroundImage:[UIImage imageNamed:@"tag_nor"] forState:UIControlStateNormal];
            button.selected=NO;
            [button setTitle:_titleArray.buttonTitleArray[k] forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(selectTag:) forControlEvents:UIControlEventTouchUpInside];
            k++;
            [tagBG addSubview:button];
            [self.view addSubview:tagBG];
        }
    }
    /**
     *  换一批button
     */
    UIButton *change=[UIButton buttonWithType:UIButtonTypeCustom];
    change.frame=CGRectMake(kScreenWidth*0.66, kScreenHeight*0.74, 100, 30);
    change.backgroundColor=[UIColor clearColor];
    [change setTitle:@"换一批" forState:UIControlStateNormal];
    [change setTitleColor:kNormalColor forState:UIControlStateNormal];
    [change setTitleColor:kSelectedColor forState:UIControlStateHighlighted];
    [change addTarget:self action:@selector(changeButtons:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:change];
    /**
     *  确定按钮
     */
    UIButton *determin=[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat nextX = kNextMargin;
    CGFloat nextW = kScreenWidth - 2*nextX;
    CGFloat nextH = kNextHeight;
    CGFloat nextY = kScreenHeight - nextH - kNextBMargin;
    determin.frame = CGRectMake(nextX, nextY, nextW, nextH);
    [determin setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
    [determin setBackgroundImage:[UIImage imageNamed:@"next_button_sel"] forState:UIControlStateHighlighted];
    [determin setTitle:@"我就是这样" forState:UIControlStateNormal];
    
    [determin addTarget:self action:@selector(determin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determin];
}
- (void)determin{
    NSMutableArray *title = [NSMutableArray array];
    for (int i = 0; i<self.arrayOfButton.count; i++) {
        [title addObject:((UIButton*)[self.view viewWithTag:1001+i]).titleLabel.text];
    }
    NSString *filePath = [NSString documentPathWithFileName:kTagFileName];
    [title writeToFile:filePath atomically:YES];
    
    WKMainViewController *main = [[WKMainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}
/**
 *  换一批按钮
 *
 *  @param button 获取新名字
 */
-(void)changeButtons:(UIButton *)button
{
    [self getButtonData];
    for (int i=0; i<10; i++) {
        [ (UIButton*)[self.view viewWithTag:2000+i] setTitle:_titleArray.buttonTitleArray[i] forState:UIControlStateNormal];
        if (((UIButton*)[self.view viewWithTag:2000+i]).selected==YES) {
            [(UIButton*)[self.view viewWithTag:2000+i] setBackgroundImage:[UIImage imageNamed:@"tag_nor"] forState:UIControlStateNormal];
            ((UIButton*)[self.view viewWithTag:2000+i]).selected=NO;
        }
    }
    
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
        /**
         *  标签的tag:从1001～1001+self.arrayOfButton.count
         */
        tag.tag=1001+count;
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        CGRect rect=[button convertRect: button.bounds toView:window];
        tag.frame=rect;
        
        
        
        [UIView transitionWithView:tag duration:kAnimateInterval options:0 animations:^{
            tag.frame=CGRectMake(kScreenWidth*0.06+count*kScreenWidth*0.323, kScreenHeight*0.17, kScreenWidth*0.234, kScreenHeight*0.05);
        } completion:^(BOOL finished) {
            NSLog(@"动画结束");
        }];
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
    [UIView transitionWithView:button duration:kAnimateInterval options:0 animations:^{
        button.center=CGPointMake(button.frame.origin.x-320, 0);
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
            [button removeFromSuperview];
    }];


    if (mark==1001) {
        for (UIButton *btn in self.arrayOfButton) {
            CGFloat x=btn.frame.origin.x;
            [UIView transitionWithView:button duration:kAnimateInterval options:0 animations:^{
                btn.frame=CGRectMake(x-kScreenWidth*0.323, kScreenHeight*0.17, kScreenWidth*0.234, kScreenHeight*0.05);
                btn.tag=btn.tag-1;
            } completion:^(BOOL finished) {
                NSLog(@"动画结束");
            }];

        }
    }else
    {
        for (UIButton *btn in self.arrayOfButton) {
            if (btn.tag-1000>2) {
                CGFloat x=btn.frame.origin.x;
                [UIView transitionWithView:button duration:kAnimateInterval options:0 animations:^{
                    btn.frame=CGRectMake(x-kScreenWidth*0.323, kScreenHeight*0.17, kScreenWidth*0.234, kScreenHeight*0.05);
                    btn.tag=btn.tag-1;
                } completion:^(BOOL finished) {
                    NSLog(@"动画结束");
                }];

            }
        }
    }
}
@end
