//
//  WKMessage.m
//  CosChat
//
//  Created by zzx🐹 on 15/5/18.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKMessage.h"
#import "WKSettingGroup.h"
#import "WKSettingSwitchItem.h"

@implementation WKMessage
/**
 *  第一组数据
 */
-(void)setGroup0
{
    WKSettingItem *notification=[WKSettingItem itemWithTitle:@"新消息通知"];
    BOOL isRemoteNotify = [UIApplication sharedApplication].isRegisteredForRemoteNotifications;
    NSLog(@"%d",isRemoteNotify);
    if (isRemoteNotify==YES)
    {
        notification.subtitle=@"已开启";
    } else
    {
         notification.subtitle=@"已关闭";
    }

    WKSettingGroup *group=[[WKSettingGroup alloc]init];
    group.items=@[notification];
    group.footer=@"在iPhone的”设置“-”通知“中进行修改";
    [self.data addObject:group];
}
/**
 *  第二组
 */
-(void)setGroup1
{
    WKSettingItem *sound=[WKSettingSwitchItem itemWithTitle:@"声音"];
    WKSettingItem *shake=[WKSettingSwitchItem itemWithTitle:@"震动"];
    WKSettingGroup *group=[[WKSettingGroup alloc]init];
    group.items=@[sound,shake];
    [self.data addObject:group];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setGroup0];
    [self setGroup1];
}
@end
