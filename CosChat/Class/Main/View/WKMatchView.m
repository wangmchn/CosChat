//
//  WKMatchView.m
//  CosChat
//
//  Created by Mark on 15/5/20.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKMatchView.h"
#import "IMStore.h"
#import <AVOSCloudIM/AVOSCloudIM.h>
#import <AFNetworking.h>
#define kAddress @"http://192.168.0.177:8080/Cos_Chat/"
#define myClientId @"12345678"
@interface WKMatchView (){
    BOOL matched;
}
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation WKMatchView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
        temp.center = self.center;
        temp.font = [UIFont boldSystemFontOfSize:20];
        temp.textColor = [UIColor whiteColor];
        temp.numberOfLines = 0;
        temp.text = @"animating..waiting for another one!";
        [self addSubview:temp];
    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    __weak typeof(self) wself = self;
    CGRect superFrame = newSuperview.frame;
    superFrame.origin.x = +superFrame.size.width;
    self.frame = superFrame;
    [UIView animateWithDuration:0.5 animations:^{
        wself.frame = newSuperview.frame;
    } completion:^(BOOL finished) {
        IMStore *store = [IMStore sharedIMStore];
        [store.imClient openWithClientId:myClientId callback:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                wself.timer = [NSTimer timerWithTimeInterval:2.0f target:wself selector:@selector(sendMatchRequest) userInfo:nil repeats:YES];
                [wself.timer fire];
            }
        }];
    }];
}
- (void)sendMatchRequest{
    
    __weak typeof(self) wself = self;
    NSLog(@"sendMatchRequest...");
    
    
    NSString *strURL = [NSString stringWithFormat:@"%@%@",kAddress,@"openChat"];
    NSLog(@"%@",strURL);
//    NSDictionary *dict = @{@"chatterName":@"凤凰",
//                           @"identifier":myClientId
//                           };
    NSString *body = @"{\"chatterName\":\"凤凰\",\"identifier\":\"33444\"}";
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:bodyData];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"------------------------%@",dict);
            if (1) {
                if ([wself.delegate respondsToSelector:@selector(matchView:didFinishMatchWithInfo:)]) {
                    [wself.delegate matchView:wself didFinishMatchWithInfo:dict];
                }
                [wself.timer invalidate];
            }
        }else{
            NSLog(@"%@",[connectionError description]);
            if ([wself.delegate respondsToSelector:@selector(matchView:didFinishMatchWithInfo:)]) {
                [wself.delegate matchView:wself didFinishMatchWithInfo:nil];
            }
            [wself.timer invalidate];
        }
    }];
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:strURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//        [wself.timer invalidate];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
}
@end
