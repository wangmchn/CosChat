//
//  IMStore.m
//  CosChat
//
//  Created by Mark on 15/5/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "IMStore.h"

@interface IMStore ()

@end

static id _IMStore;
@implementation IMStore
// set up
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
        
    }
    return self;
}
@end
