//
//  WKSettingItem.h
//  Lottery
//
//  Created by WK🐹 on 15/4/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^WKSettingItemOption)();
@interface WKSettingItem : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;
/**
 *  点击那个cell需要做什么事情
 */
@property (nonatomic, copy) WKSettingItemOption option;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
