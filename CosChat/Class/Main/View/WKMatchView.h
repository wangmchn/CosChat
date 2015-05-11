//
//  WKMatchView.h
//  CosChat
//
//  Created by Mark on 15/5/9.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKMatchContent;
@class WKMatchView;
@protocol WKMatchViewDelegate <NSObject>
@optional
- (void)matchViewDidPressedByUser:(WKMatchView *)matchView;
- (void)matchViewDidDisapper:(WKMatchView *)matchView;
@end


@interface WKMatchView : UIView
@property (nonatomic, weak) id<WKMatchViewDelegate> delegate;
@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, strong) WKMatchContent *content;
@end
