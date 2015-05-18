//
//  WKImageCache.m
//  CosChat
//
//  Created by Mark on 15/5/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKImageCache.h"
#import "UIImage+Circle.h"
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
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _imageCache = [[self alloc] init];
    });
    return _imageCache;
}
// init
- (instancetype)init{
    if (self = [super init]) {
        fileManager = [NSFileManager defaultManager];
        // 通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanDisk)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return [self.memCache objectForKey:key];
}
// 从沙盒缓存中找图片
- (UIImage *)imageFromDiskCacheForKey:(NSString *)key{
    NSString *fileName = [self cachedFileNameForKey:key];
    NSString *filePath = [self.directoryPath stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:filePath]) {
        // 沙盒存在，加载图片，并添加到内存缓存
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:data];
        if (![self.memCache objectForKey:key]) {
            [self.memCache setObject:image forKey:key];
        }
        return image;
    }
    return nil;
}
// 从远程服务器下载图片,并缓存
- (void)downloadImageWithURL:(NSString *)strURL completion:(WKImageCacheDownloadCompletion)doneBlock{
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                @autoreleasepool {
                    UIImage *initialImage = [UIImage imageWithData:data];
                    UIImage *image = [UIImage circleImageWithImage:initialImage borderWidth:kBorderWidth borderColor:kBorderColor];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 回到主线程，传值
                        doneBlock(image,connectionError);
                    });
                    if (image) {
                        // 存储图片
                        NSString *key = [strURL lastPathComponent];
                        [self storeImage:image forKey:key toDisk:YES];
                    }
                }
            });
        }else{
            doneBlock(nil,connectionError);
        }
    }];
}
#pragma mark Store Image
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk{
    // 若缓存中没有，则先在缓存中存一份
    if (![self.memCache objectForKey:key]) {
        [self.memCache setObject:image forKey:key];
    }
    if (toDisk) {
        // 存到沙盒
        [self storeImageToDisk:image forKey:key];
    }
}
- (void)storeImageToDisk:(UIImage *)image forKey:(NSString *)key{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 异步无法访问主线程的 autoreleasepool (有创建才需要？)
        @autoreleasepool {
            NSString *pathComponent = [self cachedFileNameForKey:key];
            NSString *filePath = [self.directoryPath stringByAppendingPathComponent:pathComponent];
            NSData *data = UIImagePNGRepresentation(image);
            [data writeToFile:filePath atomically:YES];
        }
    });
}
#pragma mark Remove Image
- (void)removeAllImageFromDisk:(WKClearMemoryComletion)completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([fileManager fileExistsAtPath:self.directoryPath]) {
            [fileManager removeItemAtPath:self.directoryPath error:nil];
            [fileManager createDirectoryAtPath:self.directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });

}
- (void)removeImageByKey:(NSString *)key fromDisk:(BOOL)fromDisk completion:(WKClearMemoryComletion)completion{
    [self removeImageFromMemoryByKey:key];
    
    if (fromDisk) {
        [self removeImageFromDiskByKey:key completion:completion];
    }
}
- (void)removeImageFromMemoryByKey:(NSString *)key{
    if ([self.memCache objectForKey:key]) {
        [self.memCache removeObjectForKey:key];
    }
}
- (void)removeImageFromDiskByKey:(NSString *)key completion:(WKClearMemoryComletion)completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSString *filename = [self cachedFileNameForKey:key];
            NSString *filePath = [self.directoryPath stringByAppendingPathComponent:filename];
            if ([fileManager fileExistsAtPath:filePath]) {
                [fileManager removeItemAtPath:filePath error:nil];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    });
}
#pragma mark - Private Methods
- (void)clearMemory{
    [self.memCache removeAllObjects];
}
- (void)cleanDisk{
    [self removeAllImageFromDisk:nil];
}
- (NSString *)filePathForName:(NSString *)name{
    NSString *directory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return [directory stringByAppendingPathComponent:name];
}
// MD5加密
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
