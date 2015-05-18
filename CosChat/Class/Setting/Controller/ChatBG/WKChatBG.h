//
//  WKChatBG.h
//  CosChat
//
//  Created by zzx🐹 on 15/5/18.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKChatBG;

@protocol WKChatBGDelegate <NSObject>

-(void)WKChatBG:(WKChatBG*)ChatBG didChangeBG:(NSInteger)backgroundName;

@end

@interface WKChatBG : UIViewController
@property (nonatomic, assign) id<WKChatBGDelegate>delegate;
@end
