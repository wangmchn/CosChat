//
//  WKImageCache.h
//  CosChat
//
//  Created by Mark on 15/5/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^WKImageCacheDownloadCompletion)(UIImage *image,NSError *error);
typedef void(^WKClearMemoryComletion)();

@interface WKImageCache : NSObject
+ (instancetype)sharedImageCache;
/**
 *  从远程服务器下载图片,并缓存在内存和沙盒中
 *
 *  @param strURL    下载图片的路径
 *  @param doneBlock 下载完成后执行的block操作
 */
- (void)downloadImageWithURL:(NSString *)strURL completion:(WKImageCacheDownloadCompletion)doneBlock;
/**
 *  通过key从内存中找图片，若没有该图片则去沙盒加载图片
 *
 *  @param key 寻找图片的钥匙(一般为图片名 xxx.png/jpg)
 *
 *  @return UIImage，若两边都没找到，则返回nil
 */
- (UIImage *)queryImageByKey:(NSString *)key;
/**
 *  将图片存在缓存中(沙盒)
 *
 *  @param image  要存的图片
 *  @param key    图片对应的key(一般为图片名 xxx.png/jpg)
 *  @param toDisk 是否存到沙盒中
 */
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk;
/**
 *  将图片存在沙盒中(不存缓存)
 *
 *  @param image 图片
 *  @param key   图片对应的key(一般为图片名 xxx.png/jpg)
 */
- (void)storeImageToDisk:(UIImage *)image forKey:(NSString *)key;
/**
 *  清除沙盒中所有图片
 *
 *  @param completion 完成后执行的代码块
 */
- (void)removeAllImageFromDisk:(WKClearMemoryComletion)completion;
/**
 *  通过对应的key清除图片
 *
 *  @param key        图片对应的key(一般为图片名 xxx.png/jpg)
 *  @param fromDisk   是否从沙盒中清除
 *  @param completion 完成后执行的代码块
 */
- (void)removeImageByKey:(NSString *)key fromDisk:(BOOL)fromDisk completion:(WKClearMemoryComletion)completion;
/**
 *  通过对应的key删除沙盒的图片
 *
 *  @param key        图片对应的key(一般为图片名 xxx.png/jpg)
 *  @param completion 完成后执行的代码块
 */
- (void)removeImageFromDiskByKey:(NSString *)key completion:(WKClearMemoryComletion)completion;
@end
