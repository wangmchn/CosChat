//
//  WKRoleInfo.h
//  CosChat
//
//  Created by Mark on 15/5/3.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WKRoleInfo : NSObject <NSCoding, NSCopying>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *imageURL;
- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc imageURL:(NSString *)imageURL;
+ (instancetype)roleInfoWithName:(NSString *)name desc:(NSString *)desc imageURL:(NSString *)imageURL;
@end
