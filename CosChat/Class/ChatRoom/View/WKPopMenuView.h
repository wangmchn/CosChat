//
//  WKPopMenuView.h
//  CosChat
//
//  Created by Mark on 15/5/17.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKPopMenuView;
@protocol WKPopMenuDelegate <NSObject>
@optional
- (void)popMenu:(WKPopMenuView *)popMenu didFinishPickImage:(UIImage *)image;
- (void)popMenu:(WKPopMenuView *)popMenu didFinishPickMessage:(NSString *)message;
@end

@interface WKPopMenuView : UIView
@property (nonatomic, weak) id<WKPopMenuDelegate> delegate;

- (instancetype)initWithSuperViewController:(UIViewController *)superViewController;
@end
