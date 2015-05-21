//
//  MainViewController.m
//  PersonnalSignature
//
//  Created by zzx🐹 on 15/5/4.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKMainViewController.h"
#import "WKSettingViewController.h"
#import "WKChatViewController.h"
#import "WKNavigationController.h"
#import "WKMainViewController.h"
#import "WKRolePickController.h"
// View
#import "WKTagView.h"
#import "WKMatchView.h"
#import "WKConversationView.h"
// Model
#import "IMStore.h"
#import "WKConversationContent.h"
#import "WKRoleInfo.h"
#import "NSString+filePath.h"
#import "UIImage+Circle.h"
#import "Common.h"
#import <AVOSCloudIM/AVOSCloudIM.h>
// icon
#define kIconWH      (kScreenHeight/568*120)
#define kIconYMargin (kScreenHeight/568*86)
// name
#define kNameMargin  (kScreenHeight/568*20)
#define kNameH        (kScreenWidth/320*22)
#define kNameFontSize (kScreenWidth/320*22)
// desc
#define kDescXMargin (kScreenWidth/320*38)
#define kDescYMargin (kScreenHeight/568*25)
#define kDescFontSize (kScreenWidth/320*13.5)
// tag
#define kTagW 74
#define kTagH 30
#define kTagY (kScreenHeight-kScreenHeight/568*213)
#define kTagFontSize 14

#define kNextTag 1000
#define kSetMargin 30
#define kWKY 35

@interface WKMainViewController () <WKConversationViewDelegate,AVIMClientDelegate,WKMatchViewDelegate>{
    WKMatchView *_matchView;
    WKConversationView *_conversationView;
}
@property (nonatomic, strong) WKRoleInfo *roleInfo;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, weak)   UIButton *matchButton;
@end

@implementation WKMainViewController
- (WKRoleInfo *)roleInfo{
    if (_roleInfo == nil) {
        NSString *filePath = [NSString documentPathWithFileName:kRoleFileName];
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        _roleInfo = [unarchiver decodeObjectForKey:kRoleInfoKey];
        [unarchiver finishDecoding];
    }
    return _roleInfo;
}
- (NSArray *)titlesArray{
    if (_titlesArray == nil) {
        NSString *filePath = [NSString documentPathWithFileName:kTagFileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            _titlesArray = [NSArray arrayWithContentsOfFile:filePath];
        }else{
            _titlesArray = [NSArray array];
        }
    }
    return _titlesArray;
}
#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BGLayer"]];
    
    [self addTitleBar];
    [self setUI];
}
- (void)whetherShowConversation{
    NSString *filePath = [NSString documentPathWithFileName:kRecordsPlist];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        BOOL show = [dict[@"show"] boolValue];
        NSDictionary *contentDict = dict[@"content"];
        if (show) {
            WKConversationView *conversationView = [[WKConversationView alloc] initWithFrame:CGRectMake(15, 442.0/568*kScreenHeight, kScreenWidth-30, 87)];
            conversationView.delegate = self;
            NSMutableString *time = contentDict[@"time"];
            time = (NSMutableString *)[time stringByReplacingOccurrencesOfString:@" " withString:@"/"];
            time = (NSMutableString *)[time lastPathComponent];
            NSLog(@"%@",time);
            WKConversationContent *content = [[WKConversationContent alloc] initWithIcon:[UIImage imageNamed:@"superman"] name:@"超人" content:contentDict[@"content"] time:time];
            conversationView.content = content;
            
            [self.view addSubview:conversationView];
            self.matchButton.hidden = YES;
            
            dict[@"show"] = @(NO);
            [dict writeToFile:filePath atomically:YES];
            _conversationView = conversationView;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [self whetherShowConversation];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_matchView) {
        [_matchView removeFromSuperview];
    }
    if (_conversationView) {
        [_conversationView removeFromSuperview];
    }
}
#pragma mark -
// 导航栏隐藏，自己添加一个无背景的假导航栏
- (void)addTitleBar{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWKY, 81, 17)];
    imageView.image = [UIImage imageNamed:@"Coschat_green"];
    CGPoint center = imageView.center;
    center.x = self.view.center.x;
    imageView.center = center;
    [self.view addSubview:imageView];
    
    UIButton *rightItem = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kSetMargin, kWKY, 18, 18)];
    [rightItem setImage:[UIImage imageNamed:@"Settings"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightItem];
}
- (void)setting:(id)sender{
    WKSettingViewController *set = [[WKSettingViewController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}
// 角色选择界面 (heshin 日语：害嗯心嗯——>变身)
- (void)henshin:(UIGestureRecognizer *)recognizer{
    WKRolePickController *rolePick = [[WKRolePickController alloc] init];
    [self.navigationController pushViewController:rolePick animated:YES];
}
- (void)setUI{
    // 头像
    CGFloat imageWH = kIconWH;
    CGFloat imageY = kIconYMargin;
    CGFloat imageX = (kScreenWidth-imageWH)/2;
    CGRect imageFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:self.roleInfo.imageURL]) {
//        NSLog(@"fileExistsAtPath");
//        NSLog(@"%@",self.roleInfo.imageURL);
//    }else{
//        NSLog(@"!fileExistsAtPath");
//        NSLog(@"%@",self.roleInfo.imageURL);
//    }
    NSData *data = [NSData dataWithContentsOfFile:self.roleInfo.imageURL];
    UIImage *image = [UIImage imageWithData:data];
    imageView.image = [UIImage circleImageWithImage:image borderWidth:kBorderWidth borderColor:kBorderColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    // 添加头像点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(henshin:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapGesture];
    [self.view addSubview:imageView];
    
    // 名字
    CGFloat nameY = CGRectGetMaxY(imageFrame)+kNameMargin;
    CGFloat nameH = kNameH;
    CGRect nameFrame = CGRectMake(0, nameY, kScreenWidth, nameH);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameFrame];
    nameLabel.text = self.roleInfo.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont boldSystemFontOfSize:kNameFontSize];
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    // 描述
    CGFloat descX = kDescXMargin;
    CGFloat descY = CGRectGetMaxY(nameFrame)+kDescYMargin;
    CGFloat descW = kScreenWidth-2*descX;
    CGFloat descH = 50;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descX, descY, descW, descH)];
    descLabel.text = self.roleInfo.desc;
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:kDescFontSize];
    descLabel.textColor = [UIColor whiteColor];
    [descLabel sizeToFit];
    [self.view addSubview:descLabel];
    // 标签
    CGFloat tagGap = (kScreenWidth-2*kDescXMargin-kTagW*3)/2;
    for (int i = 0; i < self.titlesArray.count; i++) {
        WKTagView *tag = [[WKTagView alloc] init];
        tag.frame = CGRectMake(kDescXMargin+i*(tagGap+kTagW), kTagY, kTagW, kTagH);
        [tag setTitle:self.titlesArray[i] forState:UIControlStateNormal];
        tag.userInteractionEnabled = NO;
        [self.view addSubview:tag];
    }
    // 匹配按钮
    UIButton *match = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat matchX = kNextMargin;
    CGFloat matchH = kNextHeight;
    CGFloat matchY = kScreenHeight - matchH - kNextBMargin;
    CGFloat matchW = kScreenWidth - 2*matchX;
    match.frame = CGRectMake(matchX, matchY, matchW, matchH);
    match.tag = kNextTag;
    [match setBackgroundImage:[UIImage imageNamed:@"next_button_nor"] forState:UIControlStateNormal];
    [match setBackgroundImage:[UIImage imageNamed:@"next_button_sel"] forState:UIControlStateHighlighted];
    [match setTitle:@"开始匹配" forState:UIControlStateNormal];
    [match addTarget:self action:@selector(match:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:match];
    self.matchButton = match;
}
- (void)match:(UIButton *)sender{
    // 匹配动画界面
    WKMatchView *matchView = [[WKMatchView alloc] initWithFrame:self.view.frame];
    matchView.delegate = self;
    [self.view addSubview:matchView];
    
}
#pragma mark - Match View delegate
- (void)matchView:(WKMatchView *)matchView didFinishMatchWithInfo:(NSDictionary *)info{
    
    WKChatViewController *chat = [[WKChatViewController alloc] init];
    [self.navigationController pushViewController:chat animated:YES];
    _matchView = matchView;
}

- (void)conversationViewDidPressedByUser:(WKConversationView *)conversationView{
    // 设置已显示
    WKChatViewController *chatRoom = [[WKChatViewController alloc] init];
    [self.navigationController pushViewController:chatRoom animated:YES];
    _conversationView = conversationView;
}
- (void)conversationViewDidDisapper:(WKConversationView *)conversationView{
    [conversationView removeFromSuperview];
    // 删除已显示
    IMStore *store = [IMStore sharedIMStore];
    [store.imClient closeWithCallback:^(BOOL succeeded, NSError *error) {
        NSLog(@"%@",error);
        if (succeeded) {
            NSLog(@"close succeed");
        }
    }];
    
    UIButton *match = (UIButton *)[self.view viewWithTag:kNextTag];
    match.hidden = NO;
}
@end
