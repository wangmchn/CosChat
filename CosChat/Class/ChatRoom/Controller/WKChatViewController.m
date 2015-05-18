//
//  WKChatViewController.m
//  CosChat
//
//  Created by Mark on 15/5/7.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <AVOSCloudIM/AVOSCloudIM.h>
#import "IMStore.h"
#import "WKChatViewController.h"
#import "UUMessageCell.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
#import "UUInputFunctionView.h"
#import "ChatModel.h"
#import "Common.h"
#import "SlidingViewManager.h"
#import "WKPopMenuView.h"
#define kUUMessageIdentifier @"UUMessageCell"
#define kUUIFViewH 40
#define kChatContentY (self.chatTableView.contentOffset.y+64)
@interface WKChatViewController () <UUMessageCellDelegate, UUInputFunctionViewDelegate, UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate>
@property (nonatomic, strong) ChatModel *chatModel;
@property (nonatomic, strong) UITableView *chatTableView;
@property (nonatomic, weak)   UUInputFunctionView *IFView;
@property (nonatomic, assign) CGFloat cellMaxY;
@property (nonatomic, strong) AVIMConversation *conversation;
@property(nonatomic,strong) WKPopMenuView *popMenuView;
@property(nonatomic,strong) SlidingViewManager *slider;
@end

@implementation WKChatViewController
#pragma mark - Lazy load
- (ChatModel *)chatModel{
    if (_chatModel == nil) {
        _chatModel = [[ChatModel alloc] init];
    }
    return _chatModel;
}
#pragma mark - Private Methods
- (void)bgPressed:(UIGestureRecognizer *)sender{
    [self.IFView.TextViewInput resignFirstResponder];
}
- (void)addInputFunc{
    UUInputFunctionView *inputFunc = [[UUInputFunctionView alloc] initWithSuperVC:self];
    inputFunc.delegate = self;
    [self.view addSubview:inputFunc];
    self.IFView = inputFunc;
}
- (void)tableViewScrollToBottom {
    if (self.chatModel.items.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.items.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (void)keyboardChange:(NSNotification *)notification{
    // zzx code
    [self.slider slideViewOut];
    
    //
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    //adjust ChatTableView's height
    UUMessageCell *cell = (UUMessageCell *)[self.chatTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:self.chatModel.items.count-1 inSection:0]];
    self.cellMaxY = CGRectGetMaxY(cell.frame);
    if (notification.name == UIKeyboardWillShowNotification) {
        CGFloat KeyboardHeight = keyboardEndFrame.size.height;
        self.chatTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kUUIFViewH-KeyboardHeight);
    }else{
        CGRect tempFrame = self.view.frame;
        tempFrame.size.height -= kUUIFViewH;
        self.chatTableView.frame = tempFrame;
    }
    
    [self.view layoutIfNeeded];
    
    // adjust UUInputFunctionView's originPoint
    CGRect newFrame = self.IFView.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    self.IFView.frame = newFrame;
    
    [UIView commitAnimations];
}
-(void)popMenu
{
    self.popMenuView=[[WKPopMenuView alloc]init];
    //    self.popMenuView.backgroundColor=[UIColor redColor];
    self.slider=[[SlidingViewManager alloc]initWithInnerView:self.popMenuView containerView:self.view];
    [self.slider slideViewIn];
    
    CGFloat newHeight=self.IFView.frame.size.height;
    CGFloat newY=kScreenHeight-self.popMenuView.frame.size.height-newHeight;
    CGFloat newX=0;
    CGFloat newWidth=self.IFView.frame.size.width;
    self.IFView.frame=CGRectMake(newX, newY, newWidth, newHeight);
    
}
#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatModel = [[ChatModel alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"尔康";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgPressed:)];
    [self.view addGestureRecognizer:tap];
    
    CGRect chatViewFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kUUIFViewH);
    UITableView *chatView = [[UITableView alloc] initWithFrame:chatViewFrame];
    // 去线
    chatView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:chatView];
    self.chatTableView = chatView;
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    self.chatTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self addInputFunc];
    
    IMStore *store = [IMStore sharedIMStore];
    NSString *myId = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSLog(@"%@",myId);
    NSString *otherId = @"123456";
    NSArray *array = @[myId,otherId];
    __weak typeof(self) weakSelf = self;
    store.imClient.delegate = self;

    
    [store.imClient createConversationWithName:nil clientIds:array attributes:@{@"type":@0} options:AVIMConversationOptionNone callback:^(AVIMConversation *conversation, NSError *error) {
        if (error) {
            NSLog(@"%@",[error description]);
        }else{
            weakSelf.conversation = conversation;
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // add notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.chatModel.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }
    UUMessageFrame *msgFrame = self.chatModel.items[indexPath.row];
    [cell setMessageFrame:msgFrame];
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UUMessageFrame *messageFrame = self.chatModel.items[indexPath.row];
    return messageFrame.cellHeight;
}

#pragma mark - UUInputFuncDelegate
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message{
    [self.conversation sendMessage:[AVIMMessage messageWithContent:message] callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"succeeded");
//            self.chatModel addTextMessageWithIcon:<#(NSString *)#> strId:<#(NSString *)#> time:<#(NSString *)#> name:<#(NSString *)#> strContent:<#(NSString *)#> from:<#(MessageFrom)#>
            [self.chatTableView reloadData];
            [self tableViewScrollToBottom];
        }else{
            NSLog(@"%@",[error description]);
        }
    }];
    
}
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image{
    
    NSDictionary *dic = @{@"picture": image,
                          @"type": @(UUMessageTypePicture)};
//    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second{
    NSDictionary *dic = @{@"voice": voice,
                          @"strVoiceTime": [NSString stringWithFormat:@"%d",(int)second],
                          @"type": @(UUMessageTypeVoice)};
//    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView didPressedPlusButton:(UIButton *)plusButton{
    [self popMenu];
}
#pragma mark - UUMessageCell delegate
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId{
    NSLog(@"%@",userId);
}
- (void)cellContentDidClick:(UUMessageCell *)cell image:(UIImage *)contentImage{
    NSLog(@"%@",cell);
}
#pragma mark - IMClient delegate
- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message{
    self.conversation = conversation;
    NSLog(@"------");
    NSLog(@"%@",message.content);
    [[[UIAlertView alloc] initWithTitle:nil message:message.content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    NSDictionary *dic = @{@"strContent": message.content,
                          @"type": @(UUMessageTypeText)};
    
//    [self.chatModel addSpecifiedItemFromOther:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}
@end
