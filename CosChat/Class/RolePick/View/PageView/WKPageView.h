//
//  WKPageView.h
//  CosChat
//
//  Created by Mark on 15/4/27.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKPageCell;
@class WKPageView;
@class WKMenuView;
typedef enum{
    WKMenuItemTitleSizeStateNormal,
    WKMenuItemTitleSizeStateSelected
} WKMenuItemTitleSizeState;
typedef enum{
    WKMenuItemTitleColorStateNormal,
    WKMenuItemTitleColorStateSelected
} WKMenuItemTitleColorState;
/**
 *  数据源
 */
@protocol WKPageViewDataSource <NSObject>
@required
/**
 *  数据源方法，获取pageView的cell个数
 *
 *  @param pageView 翻页视图
 *
 *  @return pageView的cell个数
 */
- (NSUInteger)numbersOfPagesInPageView:(WKPageView *)pageView;
/**
 *  数据源方法，获取当前index的cell
 *
 *  @param pageView 翻页视图
 *  @param index    cell的序号
 *
 *  @return WKPageCell
 */
- (WKPageCell *)pageView:(WKPageView *)pageView cellForIndex:(NSInteger)index;
/**
 *  数据源方法，获取当前menuView的items标题，以NSArray的形式
 *
 *  @param pageView 翻页视图
 *
 *  @return menuView的items的标题 (字符串，用NSArray封装)
 */
- (NSArray *)menuItemsForMenuViewInPageView:(WKPageView *)pageView;
@end
/**
 *  代理
 */
@protocol WKPageViewDelegate <NSObject>
@optional
/**
 *  设置menuView的高度，默认为30
 *
 *  @param pageView 当前翻页视图
 *  @param menuView 顶部菜单视图
 *
 *  @return menuView的高度
 */
- (CGFloat)pageView:(WKPageView *)pageView heightForMenuView:(WKMenuView *)menuView;
/**
 *  监听menuView的搜索按钮的点击事件
 *
 *  @param pageView     当前pageView
 *  @param searchButton 顶部菜单的search按钮
 */
- (void)pageView:(WKPageView *)pageView didPressedSearchButton:(UIButton *)searchButton;
/**
 *  设置menuView的背景颜色,默认：[UIColor colorWithRed:172.0/255.0 green:165.0/255.0 blue:162.0/255.0 alpha:1.0]
 *  @param pageView 当前翻页视图
 *
 *  @return UIColor
 */
- (UIColor *)backgroundColorOfMenuViewInPageView:(WKPageView *)pageView;
/**
 *  设置菜单栏标题颜色(若要动画必须创建自RGBA,或者某些有RGB分量的UIColor如:redColor,而例如grayColor不行)
 *
 *  @param pageView 当前翻页视图
 *  @param state    分为WKMenuItemTitleColorStateNormal(未选中)/WKMenuItemTitleColorStateSelected(选中)
 *
 *  @return UIColor(RBGA)
 */
- (UIColor *)titleColorOfMenuItemInPageView:(WKPageView *)pageView withState:(WKMenuItemTitleColorState)state;
/**
 *  设置菜单栏标题字体大小(大于零)
 *
 *  @param pageView 当前翻页视图
 *  @param state    分为WKMenuItemTitleSizeStateNormal(未选中)/WKMenuItemTitleSizeStateSelected(选中)
 *
 *  @return 标题字体大小
 */
- (CGFloat)titleSizeOfMenuItemInPageView:(WKPageView *)pageView withState:(WKMenuItemTitleSizeState)state;
@end

@interface WKPageView : UIView
@property (nonatomic, weak) id<WKPageViewDataSource> dataSource;
@property (nonatomic, weak) id<WKPageViewDelegate> delegate;
/**
 *  刷新数据
 */
- (void)reloadData;
/**
 *  还未实现,等待实现
 *
 *  @param index 刷新的Page位置
 */
- (void)reloadDataForPage:(NSInteger)index;
/**
 *  从缓存池中取出可重用的cell，若没有则返回nil
 *
 *  @param identifier 重用cell的标识符
 *
 *  @return 返回Cell以供重用
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end
