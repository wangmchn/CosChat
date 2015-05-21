//
//  WKMatchView.h
//  CosChat
//
//  Created by Mark on 15/5/9.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKConversationView;
@class WKConversationContent;
@protocol WKConversationViewDelegate <NSObject>
@optional
- (void)conversationViewDidPressedByUser:(WKConversationView *)conversationView;
- (void)conversationViewDidDisapper:(WKConversationView *)conversationView;
@end


@interface WKConversationView : UIView
@property (nonatomic, weak) id<WKConversationViewDelegate> delegate;
@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, strong) WKConversationContent *content;
@end
