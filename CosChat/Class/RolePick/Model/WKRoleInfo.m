//
//  WKRoleInfo.m
//  CosChat
//
//  Created by Mark on 15/5/3.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKRoleInfo.h"

@implementation WKRoleInfo
- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc imageURL:(NSString *)imageURL{
    if (self = [super init]) {
        _name = name;
        _desc = desc;
        _imageURL = imageURL;
    }
    return self;
}
+ (instancetype)roleInfoWithName:(NSString *)name desc:(NSString *)desc imageURL:(NSString *)imageURL{
    return [[self alloc] initWithName:name desc:desc imageURL:imageURL];
}
@end
