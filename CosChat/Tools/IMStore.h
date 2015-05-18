//
//  IMStore.h
//  CosChat
//
//  Created by Mark on 15/5/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVIMClient;
@interface IMStore : NSObject
@property (nonatomic, strong) AVIMClient *imClient;
+ (instancetype)sharedIMStore;
@end
