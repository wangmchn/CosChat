//
//  WKSettingItem.m
//  Lottery
//
//  Created by WK🐹 on 15/4/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WKSettingItem.h"

@implementation WKSettingItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    WKSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}
@end
