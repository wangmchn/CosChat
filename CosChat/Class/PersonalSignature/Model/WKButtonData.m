//
//  WKButtonData.m
//  CosChat
//
//  Created by zzx🐹 on 15/5/6.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKButtonData.h"

@implementation WKButtonData
- (instancetype)initWithButtonTitle:(NSMutableArray*)buttonTitleArray
{
    if (self = [super init]) {
        _buttonTitleArray = buttonTitleArray;
    }
    return self;
}
@end
