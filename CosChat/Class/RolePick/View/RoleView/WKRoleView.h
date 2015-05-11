//
//  WKRoleView.h
//  CosChat
//
//  Created by Mark on 15/5/3.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKRoleInfo.h"
@interface WKRoleView : UIView
@property (nonatomic, strong) WKRoleInfo *roleInfo;
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *descLabel;
@end
