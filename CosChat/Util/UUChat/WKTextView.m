//
//  WKTextView.m
//  CosChat
//
//  Created by Mark on 15/5/20.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKTextView.h"
#define kTimeInterval 0.2

@interface WKTextView (){
    BOOL toFit;
}

@end

@implementation WKTextView
- (void)setContentSize:(CGSize)contentSize{
    CGSize oriSize = self.frame.size;
    [super setContentSize:contentSize];
    
    __weak typeof(self) wself = self;
    if(toFit && oriSize.height != self.contentSize.height && self.contentSize.height <= 100){
        if([self.myDelegate respondsToSelector:@selector(textView:heightChanged:animateDuration:)]){
            [self.myDelegate textView:self heightChanged:self.contentSize.height - oriSize.height animateDuration:kTimeInterval];
        }
        [UIView animateWithDuration:0.2f animations:^{
            CGRect newFrame = wself.frame;
            newFrame.size.height = wself.contentSize.height;
            wself.frame = newFrame;
        }];
        
    }
    toFit = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
