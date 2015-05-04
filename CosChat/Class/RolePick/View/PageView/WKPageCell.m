//
//  WKPageCell.m
//  CosChat
//
//  Created by Mark on 15/4/27.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKPageCell.h"
#define kLineSpacing 0.5
@implementation WKPageCell
- (id)initWithIdentifier:(NSString *)identifier{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = kLineSpacing;
    flow.minimumInteritemSpacing = kLineSpacing;
    CGFloat width = [UIScreen mainScreen].bounds.size.width/2-kLineSpacing;
    flow.itemSize = CGSizeMake(width, width/1.29);
    
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flow]) {
        _identifier = identifier;
    }
    return self;
}
@end
