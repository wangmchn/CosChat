//
//  WKSettingCell.h
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKSettingItem;

@interface WKSettingCell : UITableViewCell
@property (nonatomic, strong) WKSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
