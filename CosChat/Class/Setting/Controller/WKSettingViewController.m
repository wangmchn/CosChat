//
//  WKSettingViewController.m
//  Lottery
//
//  Created by WK🐹 on 15/4/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WKSettingViewController.h"
#import "WKSettingArrowItem.h"
#import "WKSettingSwitchItem.h"
#import "WKSettingGroup.h"
#import "WKMessage.h"
#import "WKChatBG.h"
#import "WKAboutViewController.h"
@interface WKSettingViewController()
@end
@implementation WKSettingViewController


/**
 *  第0组数据
 */
-(void)setupGroup0
{
    WKSettingItem *message= [WKSettingArrowItem itemWithIcon:nil title:@"消息提醒" destVcClass:[WKMessage class]];

    
    WKSettingGroup *group = [[WKSettingGroup alloc] init];
    group.items = @[message];
    group.footer=@"在这里可以设置接收到的新消息的提醒方式";
    [self.data addObject:group];
}
/**
 *  第1组数据
 */
-(void)setupGroup1
{
    WKSettingItem *chatBG=[WKSettingArrowItem itemWithIcon:nil title:@"聊天背景" destVcClass:[WKChatBG class]];
    WKSettingItem *introduce=[WKSettingArrowItem itemWithIcon:nil title:@"功能介绍" destVcClass:[WKChatBG class]];
    WKSettingItem *about=[WKSettingArrowItem itemWithIcon:nil title:@"关于" destVcClass:[WKAboutViewController class]];
    WKSettingGroup *group = [[WKSettingGroup alloc] init];
    group.items = @[chatBG,introduce,about];
    [self.data addObject:group];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.标题
    self.title = @"设置";
    
    // 2.添加数据
    [self setupGroup0];
    [self setupGroup1];
}
@end
