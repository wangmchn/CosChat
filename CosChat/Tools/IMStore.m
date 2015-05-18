//
//  IMStore.m
//  CosChat
//
//  Created by Mark on 15/5/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "IMStore.h"
#import <AVOSCloudIM/AVOSCloudIM.h>
@interface IMStore () <AVIMClientDelegate>
@property (nonatomic, strong) NSCache *cache;
@end

static id _IMStore;
@implementation IMStore
#pragma mark - Set up
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _IMStore = [super allocWithZone:zone];
    });
    return _IMStore;
}
+ (instancetype)sharedIMStore{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _IMStore = [[self alloc] init];
    });
    return _IMStore;
}
- (instancetype)init{
    if (self = [super init]) {
        self.imClient = [[AVIMClient alloc] init];
    }
    return self;
}

- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message{
    
}
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message{

}
- (void)conversation:(AVIMConversation *)conversation messageDelivered:(AVIMMessage *)message{
    NSLog(@"%@",message.content);
}
@end
