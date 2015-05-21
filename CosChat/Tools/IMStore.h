//
//  IMStore.h
//  CosChat
//
//  Created by Mark on 15/5/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVIMClient;
@class AVIMConversation;
@interface IMStore : NSObject
@property (nonatomic, strong) AVIMClient *imClient;
@property (nonatomic, strong) AVIMConversation *conversation;
@property (nonatomic, strong) NSMutableDictionary *conversations;
+ (instancetype)sharedIMStore;
@end
