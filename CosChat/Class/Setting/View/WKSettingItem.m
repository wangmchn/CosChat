//
//  WKSettingItem.m
//  CosChat
//
//  Created by zzx🐹 on 15/4/30.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKSettingItem.h"


@implementation WKSettingItem

+(instancetype)itemWithTitle:(NSString *)title vcClass:(Class)vcClass
{
    WKSettingItem *item=[[self alloc]init];
    item.title=title;
    item.vcClass=vcClass;
    return item;
}
@end
