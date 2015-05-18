//
//  SlidingViewManager.m
//  FilterOfPic
//
//  Created by zzx🐹 on 15/3/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//
#import "SlidingViewManager.h"

@implementation SlidingViewManager {
    BOOL visible;
    UIView *innerView;
    UIView *containerView;
}

- (id)initWithInnerView:(UIView*)_innerView containerView:(UIView *)_containerView {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    innerView = _innerView;
    containerView = _containerView;
    
    return self;
}

- (void)slideViewIn {
    visible = YES;
    
    CGFloat innerWidth = CGRectGetWidth(innerView.frame);
    CGFloat innerHeight = CGRectGetHeight(innerView.frame);
    CGFloat innerX = CGRectGetMinX(innerView.frame);
    CGFloat innerOriginalY = CGRectGetHeight(containerView.frame);
    CGFloat innerTargetY = CGRectGetHeight(containerView.frame) - innerHeight;
    
    CGRect original = CGRectMake(innerX, innerOriginalY, innerWidth, innerHeight);
    CGRect target = CGRectMake(innerX, innerTargetY, innerWidth, innerHeight);
    
    // Add to View
    [innerView setFrame:original];
    [containerView addSubview:innerView];
    
    // Animate In
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [innerView setFrame:target];
    } completion:nil];
}
- (void)slideViewOut {
    visible = NO;
    
    CGFloat innerWidth = CGRectGetWidth(innerView.frame);
    CGFloat innerHeight = CGRectGetHeight(innerView.frame);
    CGFloat innerX = CGRectGetMinX(innerView.frame);
    CGFloat innerOriginalY = CGRectGetHeight(containerView.frame);
    
    CGRect original = CGRectMake(innerX, innerOriginalY, innerWidth, innerHeight);
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [innerView setFrame:original];
    } completion:nil];
    [innerView removeFromSuperview];
}
@end
