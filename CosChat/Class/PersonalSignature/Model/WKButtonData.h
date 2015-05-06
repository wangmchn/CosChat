//
//  WKButtonData.h
//  CosChat
//
//  Created by zzx🐹 on 15/5/6.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKButtonData : NSObject
@property(nonatomic,copy)NSMutableArray *buttonTitleArray;
- (instancetype)initWithButtonTitle:(NSMutableArray*)buttonTitleArray;
@end
