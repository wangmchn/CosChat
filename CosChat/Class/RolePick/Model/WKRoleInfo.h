//
//  WKRoleInfo.h
//  CosChat
//
//  Created by Mark on 15/5/3.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBorderColor [UIColor colorWithRed:200.0/255.0f green:200.0/255.0f blue:200.0/255.0f alpha:1.0f]
#define kBorderWidth 7
@interface WKRoleInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *imageURL;
- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc imageURL:(NSString *)imageURL;
+ (instancetype)roleInfoWithName:(NSString *)name desc:(NSString *)desc imageURL:(NSString *)imageURL;
@end
