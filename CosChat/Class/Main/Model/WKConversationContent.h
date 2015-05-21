//
//  WKMatchContent.h
//  CosChat
//
//  Created by Mark on 15/5/9.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WKConversationContent : NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, copy)   NSString *time;
@property (nonatomic, strong) UIImage  *icon;
- (instancetype)initWithIcon:(UIImage *)icon name:(NSString *)name content:(NSString *)content time:(NSString *)time;
@end
