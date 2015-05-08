//
//  NSString+FilePath.m
//  CosChat
//
//  Created by Mark on 15/5/6.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "NSString+FilePath.h"

@implementation NSString (filePath)
+ (NSString *)documentPathWithFileName:(NSString *)fileName{
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [filePath stringByAppendingPathComponent:fileName];
}
+ (NSString *)cachePathWithFileName:(NSString *)fileName{
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return [filePath stringByAppendingPathComponent:fileName];
}
@end
