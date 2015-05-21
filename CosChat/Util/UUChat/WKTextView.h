//
//  WKTextView.h
//  CosChat
//
//  Created by Mark on 15/5/20.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKTextView;
@protocol WKTextViewDelegate <UITextViewDelegate>
@optional
- (void)textView:(WKTextView *)textView heightChanged:(CGFloat)change animateDuration:(CGFloat)timeInterval;

@end

@interface WKTextView : UITextView
@property (nonatomic, weak) id<WKTextViewDelegate> myDelegate;
@end
