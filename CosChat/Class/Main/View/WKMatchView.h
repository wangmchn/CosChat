//
//  WKMatchView.h
//  CosChat
//
//  Created by Mark on 15/5/20.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKMatchView;
@protocol WKMatchViewDelegate <NSObject>
@optional
- (void)matchView:(WKMatchView *)matchView didFinishMatchWithInfo:(NSDictionary *)info;

@end

@interface WKMatchView : UIView
@property (nonatomic, weak) id<WKMatchViewDelegate> delegate;
@end
