//
//  UUMessage+Mark.m
//  CosChat
//
//  Created by Mark on 15/5/14.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "UUMessage+Mark.h"

@implementation UUMessage (Mark)
- (instancetype)initWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName from:(MessageFrom)from{
    if (self = [super init]) {
        self.strIcon = strIcon;
        self.strId = strId;
        self.strTime = strTime;
        self.strName = strName;
        self.from = from;
    }
    return self;
}
@end
