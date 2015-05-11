//
//  WKImageCache.m
//  CosChat
//
//  Created by Mark on 15/5/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKImageCache.h"
#import <CommonCrypto/CommonCrypto.h>

#define kCacheName  @"com.coschat.icons"
#define kCountLimit 20
@interface WKImageCache () <NSCacheDelegate>{
    NSFileManager *fileManager;
}
@property (nonatomic, strong) NSMutableDictionary *imageURLs;
@property (nonatomic, strong) NSMutableDictionary *operations;
@property (nonatomic, copy)   NSString *directoryPath;
@property (nonatomic, strong) NSCache  *memCache;
@end
@implementation WKImageCache
// 全局变量
static id _imageCache;
#pragma mark - Set UP
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _imageCache = [super allocWithZone:zone];
    });
    return _imageCache;
}
+ (instancetype)sharedImageCache{
    _imageCache = [[self alloc] init];
    return _imageCache;
}
- (instancetype)init{
    if (self = [super init]) {
        fileManager = [NSFileManager defaultManager];
    }
    return self;
}
#pragma mark - Lazy Load
// 内存缓存
- (NSCache *)memCache{
    if (_memCache == nil) {
        _memCache = [[NSCache alloc] init];
        _memCache.countLimit = kCountLimit;
        _memCache.delegate = self;
        _memCache.name = kCacheName;
    }
    return _memCache;
}
// 沙盒缓存图片的目录地址
- (NSString *)directoryPath{
    if (_directoryPath == nil) {
        _directoryPath = [self filePathForName:kCacheName];
        if (![fileManager fileExistsAtPath:_directoryPath]) {
            [fileManager createDirectoryAtPath:_directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return _directoryPath;
}
#pragma mark - Public Methods

#pragma mark Query Image
- (UIImage *)queryImageByKey:(NSString *)key{
    UIImage *image = [self imageFromMemoryCacheForKey:key];
    if (image) {
        return image;
    }else{
        return [self imageFromDiskCacheForKey:key];
    }
}
// 从内存缓存中找图片
- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key{
    return [self.memCache valueForKey:key];
}
// 从沙盒缓存中找图片
- (UIImage *)imageFromDiskCacheForKey:(NSString *)key{
    NSString *fileName = [self cachedFileNameForKey:key];
    NSString *filePath = [self.directoryPath stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:filePath]) {
        // 沙盒存在，加载图片，并添加到内存缓存
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:data];
        if (![self.memCache valueForKey:key]) {
            [self.memCache setObject:image forKey:key];
        }
        return image;
    }
    return nil;
}
// 从远程服务器下载图片


#pragma mark Store Image
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk{
    // 若缓存中没有，则现在缓存中存一份
    if (![self.memCache valueForKey:key]) {
        [self.memCache setObject:image forKey:key];
    }
    if (toDisk) {
        // 存到沙盒
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *pathComponent = [self cachedFileNameForKey:key];
            NSString *filePath = [self.directoryPath stringByAppendingPathComponent:pathComponent];
            NSData *data = UIImagePNGRepresentation(image);
            [data writeToFile:filePath atomically:YES];
        });
    }
}
#pragma mark - Private Methods
- (NSString *)filePathForName:(NSString *)name{
    NSString *directory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return [directory stringByAppendingPathComponent:name];
}
- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return filename;
}
#pragma mark - NSCache delegate
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"%@",obj);
}
@end
