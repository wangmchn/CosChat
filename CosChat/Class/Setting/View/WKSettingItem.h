//
//  WKSettingItem.h
//  CosChat
//
//  Created by zzx🐹 on 15/4/30.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKSettingItem : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)Class vcClass;
+ (instancetype)itemWithTitle:(NSString *)title vcClass:(Class)vcClass;
@end
