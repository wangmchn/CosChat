//
//  WKRoleInfo.m
//  CosChat
//
//  Created by Mark on 15/5/3.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKRoleInfo.h"
#define kNameKey @"name"
#define kDescKey @"desc"
#define kImageKey @"imageURL"
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
#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:kNameKey];
        _desc = [aDecoder decodeObjectForKey:kDescKey];
        _imageURL = [aDecoder decodeObjectForKey:kImageKey];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeObject:self.desc forKey:kDescKey];
    [aCoder encodeObject:self.imageURL forKey:kImageKey];
}
#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone{
    WKRoleInfo *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [self.name copyWithZone:zone];
    copy.desc = [self.desc copyWithZone:zone];
    copy.imageURL = [self.imageURL copyWithZone:zone];
    return copy;
}
@end
