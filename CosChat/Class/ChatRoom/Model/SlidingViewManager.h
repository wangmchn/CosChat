//
//  SlidingViewManager.h
//  FilterOfPic
//
//  Created by zzx🐹 on 15/3/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SlidingViewManager : NSObject

- (id)initWithInnerView:(UIView*)_innerView containerView:(UIView *)_containerView;
- (void)slideViewIn;
- (void)slideViewOut;

@end

