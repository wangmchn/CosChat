//
//  WKMatchView.m
//  CosChat
//
//  Created by Mark on 15/5/9.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKConversationView.h"
#import "WKConversationContent.h"
#import "UIImage+Circle.h"
#define kMargin 5.5
#define kGap 11
@interface WKConversationView ()
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation WKConversationView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        [self addContentView];
    }
    return self;
}
- (void)addContentView{
    // delete
    CGFloat width = 100;
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-width, 0, width, self.frame.size.height)];
    deleteButton.backgroundColor = [UIColor redColor];
    self.deleteButton = deleteButton;
    [self addSubview:deleteButton];
    // scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    // icon
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [view addGestureRecognizer:tap];
    [scrollView addSubview:view];
    
    UIImageView *icon = [[UIImageView alloc] init];
    [view addSubview:icon];
    self.icon = icon;
    // name
    UILabel *name = [[UILabel alloc] init];
    [view addSubview:name];
    self.nameLabel = name;
    // content
    UILabel *content = [[UILabel alloc] init];
    [view addSubview:content];
    self.contentLabel = content;
    // time
    UILabel *time = [[UILabel alloc] init];
    [view addSubview:time];
    self.timeLabel = time;
    [self addSubview:scrollView];
    self.contentView = scrollView;
    self.contentView.contentSize = CGSizeMake(self.frame.size.width+self.deleteButton.frame.size.width, self.frame.size.height);
    
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, width, self.frame.size.height)];
    UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTap:)];
    [mask addGestureRecognizer:maskTap];
    [scrollView addSubview:mask];
}
- (void)maskTap:(id)sender{
    self.contentView.pagingEnabled = NO;
    [self.contentView setContentOffset:CGPointMake(100, 0) animated:YES];
    CGRect frame = self.frame;
//    frame.size.width = 0;
    frame.origin.x = -self.frame.size.width;
    [UIView transitionWithView:self duration:0.55 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.frame = frame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(conversationViewDidDisapper:)]) {
            [self.delegate conversationViewDidDisapper:self];
        }
    }];
}
- (void)tap:(UIGestureRecognizer *)sender{
    if (self.contentView.contentOffset.x == 0) {
        if ([self.delegate respondsToSelector:@selector(conversationViewDidPressedByUser:)]) {
            [self.delegate conversationViewDidPressedByUser:self];
        }
    }else{
        [self.contentView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
- (void)setContent:(WKConversationContent *)content{
    _content = content;
    [self updateContent];
}
- (void)updateContent{
    UIImage *newImage = [UIImage circleImageWithImage:self.content.icon borderWidth:kBorderWidth borderColor:kBorderColor];
    
    self.icon.image = newImage;
    self.nameLabel.text = self.content.name;
    self.contentLabel.text = self.content.content;
    self.timeLabel.text = self.content.time;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    // icon
    CGFloat iconWH = self.frame.size.height - 2*kMargin;
    CGRect iconFrame = CGRectMake(kMargin, kMargin, iconWH, iconWH);
    self.icon.frame = iconFrame;
    // name
    CGFloat nameX = CGRectGetMaxX(iconFrame) + kGap;
    CGFloat nameY = 40.0/174.0*height;
    CGRect nameFrame = CGRectMake(nameX, nameY, 0, 0);
    self.nameLabel.font = [UIFont boldSystemFontOfSize:20];
    self.nameLabel.frame = nameFrame;
    [self.nameLabel sizeToFit];
    // content
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textColor = [UIColor grayColor];
    self.contentLabel.frame = CGRectMake(nameX, 100.0/174.0*height, width-nameX-22, 20);
    // time
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.textColor = [UIColor blackColor];
    CGFloat timeX = self.frame.size.width - 60;
    self.timeLabel.frame = CGRectMake(timeX, nameY+2, 0, 0);
    [self.timeLabel sizeToFit];
    
    
}
@end
