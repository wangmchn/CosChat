//
//  WKPageCell.h
//  CosChat
//
//  Created by Mark on 15/4/27.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKPageCell;
@protocol WKPageCellDelegate <NSObject>
@optional
- (void)pageCell:(WKPageCell *)pageCell didSelectedItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface WKPageCell : UIView
@property (nonatomic, assign) id<WKPageCellDelegate> delegate;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, weak) UICollectionView *contentView;
@property (nonatomic, strong) NSArray *dataSource;
- (id)initWithIdentifier:(NSString *)identifier;
- (void)reloadData;
@end
