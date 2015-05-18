//
//  WKChatBG.m
//  CosChat
//
//  Created by zzx🐹 on 15/5/18.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKChatBG.h"
#import "Common.h"
#define kCount 8


@interface WKChatBG ()
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *selectedImageView;
@end

@implementation WKChatBG

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    int selectedIndex = 0;
    
    /**
     *  label
     */
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(20, 64, 150, 20)];
    self.label.text=@"请选择一张背景图:";
    self.label.textColor=[UIColor colorWithWhite:0.629 alpha:1.000];
    self.label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:self.label];
    
    /**
     参数
     */

    NSInteger width=90;
    NSInteger height=160;
    NSInteger cell=kCount/3;
    NSInteger space=5;
    /**
     *  scrollvew
     */
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(20, 90, kScreenWidth-40, kScreenHeight-90)];

//    self.scrollView.backgroundColor=[UIColor greenColor];
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, (cell+1)*height+cell*space);
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<kCount; i++) {
        NSInteger row=i/3;
        NSInteger column=i%3;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        /**
         *  button tag   : 3000~3000+kCount
         */
        button.tag=3000+i;
        button.frame=CGRectMake(column*(width+space), row*(height+space), width, height);
        if (i==selectedIndex) {
            button.backgroundColor=[UIColor redColor];
            UIImageView *selIcon=[[UIImageView alloc]initWithFrame:CGRectMake(button.frame.size.width-20, button.frame.size.height-20, 20, 20)];
            selIcon.image=[UIImage imageNamed:@"background_sel"];
            [button addSubview:selIcon];
            self.selectedImageView = selIcon;
        }else
        {
        NSString *name=[NSString stringWithFormat:@"background_%d",i];
        [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(changeBG:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }
}

-(void)changeBG:(UIButton *)button
{
//    [self.delegate WKChatBG:self didChangeBG:button.tag];
    
    UIImageView *selIcon=[[UIImageView alloc]initWithFrame:CGRectMake(button.frame.size.width-20, button.frame.size.height-20, 20, 20)];
    selIcon.image=[UIImage imageNamed:@"background_sel"];
    
    if (self.selectedImageView) {
        [self.selectedImageView removeFromSuperview];
    }
    self.selectedImageView = selIcon;
    [button addSubview:selIcon];
    
}


@end
