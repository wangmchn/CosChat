//
//  WKPageCell.m
//  CosChat
//
//  Created by Mark on 15/4/27.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKPageCell.h"
#import "WKRoleCell.h"
#define kLineSpacing 0.5
#define kCollectionCellIdentifier @"collectionCell"
@interface WKPageCell () <UICollectionViewDataSource, UICollectionViewDelegate>
@end

@implementation WKPageCell
- (id)initWithIdentifier:(NSString *)identifier{
    if (self = [super init]) {
        self.identifier = identifier;
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.minimumLineSpacing = kLineSpacing;
        flow.minimumInteritemSpacing = kLineSpacing;
        CGFloat width = [UIScreen mainScreen].bounds.size.width/2-kLineSpacing;
        flow.itemSize = CGSizeMake(width, width/1.29);
        UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        [contentView registerClass:[WKRoleCell class] forCellWithReuseIdentifier:kCollectionCellIdentifier];
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.bounces = YES;
        contentView.delegate = self;
        contentView.dataSource = self;
        contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentView];
        self.contentView = contentView;
    }
    return self;
}
- (void)reloadData{
    [self.contentView reloadData];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKRoleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier forIndexPath:indexPath];
//    NSDictionary *dict = self.dataSource[indexPath.row];
//    WKRoleInfo *roleInfo = [[WKRoleInfo alloc] initWithName:dict[@"name"] desc:dict[@"content"] imageURL:[[NSBundle mainBundle] pathForResource:@"Chopper" ofType:@"png"]];
    cell.roleInfo = self.dataSource[indexPath.row];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(pageCell:didSelectedItemAtIndexPath:)]) {
        [self.delegate pageCell:self didSelectedItemAtIndexPath:indexPath];
    }
}
@end
