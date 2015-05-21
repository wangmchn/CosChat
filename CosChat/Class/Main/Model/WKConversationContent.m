//
//  WKMatchContent.m
//  CosChat
//
//  Created by Mark on 15/5/9.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKConversationContent.h"

@implementation WKConversationContent
- (instancetype)initWithIcon:(UIImage *)icon name:(NSString *)name content:(NSString *)content time:(NSString *)time{
    if (self = [super init]) {
        self.icon = icon;
        self.name = name;
        self.content = content;
        self.time = time;
    }
    return self;
}
@end
