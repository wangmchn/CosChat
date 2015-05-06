//
//  NSString+FilePath.h
//  CosChat
//
//  Created by Mark on 15/5/6.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (filePath)
+ (NSString *)stringWithDocumentPath:(NSString *)fileName;
+ (NSString *)stringWithCachePath:(NSString *)fileName;
@end
