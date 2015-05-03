//
//  WKMenuView.h
//  CosChat
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKMenuView;
@class WKMenuItem;
typedef enum{
    WKMenuSlideToNextItem,
    WKMenuSlideToFrontItem
} WKMenuSlideType;
@protocol WKMenuViewDelegate <NSObject>
@optional
- (void)menuView:(WKMenuView *)menu didSelesctedIndex:(NSInteger)index;
//- (void)menuView:(WKMenuView *)menu didPressSearchButton:(UIButton *)searchButton;
@end

@interface WKMenuView : UIView

@property (nonatomic, strong) NSArray *items;
/**
 *  每个按钮的宽度，默认宽度为50
 */
@property (nonatomic, assign) CGFloat bWidth;
@property (nonatomic, weak) id<WKMenuViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame buttonItems:(NSArray *)items backgroundColor:(UIColor *)bgColor norSize:(CGFloat)norSize selSize:(CGFloat)selSize norColor:(UIColor *)norColor selColor:(UIColor *)selColor;
- (void)slideMenuAtProgress:(CGFloat)progress;
@end
