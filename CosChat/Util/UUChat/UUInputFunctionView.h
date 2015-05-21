//
//  UUInputFunctionView.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKTextView.h"
@class UUInputFunctionView;

@protocol UUInputFunctionViewDelegate <NSObject>
@required
// text
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message;

//// image
//- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image;

// audio
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second;

// add by Mark wang
@optional
/**
 *  右边按钮的点击事件
 *
 *  @param funcView   UUInputFunctionView
 *  @param plusButton 点击的按钮
 */
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView didPressedPlusButton:(UIButton *)plusButton;
/**
 *  当InputFunction高度改变时，通知代理
 *
 *  @param funcView     InputFunctionView
 *  @param change       高度改变的值
 *  @param timeInterval 动画持续事件
 */
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView didChangedHeight:(CGFloat)change animateDuration:(CGFloat)timeInterval;
@end

@interface UUInputFunctionView : UIView <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UIButton *btnSendMessage;
@property (nonatomic, retain) UIButton *btnChangeVoiceState;
@property (nonatomic, retain) UIButton *btnVoiceRecord;
@property (nonatomic, retain) WKTextView *TextViewInput;

@property (nonatomic, assign) BOOL isAbleToSendTextMessage;

@property (nonatomic, retain) UIViewController *superVC;

@property (nonatomic, assign) id<UUInputFunctionViewDelegate> delegate;


- (id)initWithSuperVC:(UIViewController *)superVC;

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto;

@end
