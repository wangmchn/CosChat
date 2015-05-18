//
//  WKAboutViewController.m
//  CosChat
//
//  Created by zzx🐹 on 15/5/18.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKAboutViewController.h"
#import "Common.h"
#import "WKSettingArrowItem.h"
#import "WKSettingGroup.h"
#import "WKHelpViewController.h"
@interface WKAboutViewController ()

@end

@implementation WKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeadView];
    [self setGroup];
}
-(void)setGroup
{
    WKSettingItem *grade=[WKSettingItem itemWithTitle:@"去评分"];
    grade.option=^{
        NSLog(@"跳转到APP STORE");
    };
    WKSettingItem *help=[WKSettingArrowItem itemWithTitle:@"帮助与反馈" destVcClass:[WKHelpViewController class]];
    WKSettingGroup *group=[[WKSettingGroup alloc]init];
    group.items=@[grade,help];
    [self.data addObject:group];
}
/**
 *  设置headview
 */
-(void)setHeadView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , 200)];
    //    view.backgroundColor=[UIColor redColor];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(105, 36, 110, 110)];
    image.image=[UIImage imageNamed:@"Chopper"];
    [view addSubview:image];
    self.tableView.tableHeaderView=view;
    /**
     *  coschat  label
     */
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.origin.x+10, image.frame.origin.y+image.frame.size.height, 90, 20)];
    label.text=@"CosChat";
    label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:label];
    /**
     *  version label
     */
    UILabel *version=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+5, label.frame.origin.y+label.frame.size.height+3, 80, 20)];
    version.text=@"v1.0.0.0";
    version.textAlignment=NSTextAlignmentCenter;
    version.font=[UIFont systemFontOfSize:12];
    version.textColor=[UIColor colorWithWhite:0.563 alpha:1.000];
    [view addSubview:version];
}


@end
