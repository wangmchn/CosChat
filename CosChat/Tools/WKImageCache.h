//
//  WKImageCache.h
//  CosChat
//
//  Created by Mark on 15/5/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//typedef void(^) <#new#>;

@interface WKImageCache : NSObject
+ (instancetype)sharedImageCache;


- (UIImage *)queryImageByKey:(NSString *)key;
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk;
@end
