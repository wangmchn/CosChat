//
//  UUMessage+Mark.h
//  CosChat
//
//  Created by Mark on 15/5/14.
//  Copyright (c) 2015年 yq. All rights reserved.
//
#import "UUMessage.h"

@interface UUMessage (Mark)
- (instancetype)initWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName from:(MessageFrom)from;
@end
