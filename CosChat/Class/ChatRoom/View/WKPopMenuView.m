//
//  WKPopMenuView.m
//  CosChat
//
//  Created by Mark on 15/5/17.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WKPopMenuView.h"
#import "Common.h"
#define kPopMenuHeight 130
#define kItemWH  60
#define kMarginX 40
#define kMarginY 20

@interface WKPopMenuView () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIViewController *superVC;
@end

@implementation WKPopMenuView
- (instancetype)initWithSuperViewController:(UIViewController *)superViewController{
    if (self = [super init]) {
        self.superVC = superViewController;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, kScreenHeight-kPopMenuHeight, kScreenWidth, kPopMenuHeight);
        
        [self addItems];
    }
    return self;
}

- (void)addItems{
    int count = 3;
    CGFloat gap = (self.frame.size.width - kItemWH*count - kMarginX*2)/(count-1);
    CGFloat stepX = gap+kItemWH;
    // 照片
    UIButton *picture = [[UIButton alloc] initWithFrame:CGRectMake(kMarginX, kMarginY, kItemWH, kItemWH)];
    [picture setTitle:@"图片" forState:UIControlStateNormal];
    [picture addTarget:self action:@selector(picture) forControlEvents:UIControlEventTouchUpInside];
    picture.backgroundColor = [UIColor redColor];
    [self addSubview:picture];
    // 拍照
    UIButton *camera = [[UIButton alloc] initWithFrame:CGRectMake(kMarginX+stepX, kMarginY, kItemWH, kItemWH)];
    [camera setTitle:@"拍照" forState:UIControlStateNormal];
    [camera addTarget:self action:@selector(camera) forControlEvents:UIControlEventTouchUpInside];
    camera.backgroundColor = [UIColor redColor];
    [self addSubview:camera];
    // 聊天语句
    UIButton *chats = [[UIButton alloc] initWithFrame:CGRectMake(kMarginX+stepX*2, kMarginY, kItemWH, kItemWH)];
    [chats setTitle:@"聊天语" forState:UIControlStateNormal];
    [chats addTarget:self action:@selector(chatSentences) forControlEvents:UIControlEventTouchUpInside];
    chats.backgroundColor = [UIColor redColor];
    [self addSubview:chats];
}
- (void)picture{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.superVC presentViewController:picker animated:YES completion:^{
        }];
    }
}
- (void)camera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.superVC presentViewController:picker animated:YES completion:^{}];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)chatSentences{
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData *data = UIImagePNGRepresentation(editImage);
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.png"];
    [data writeToFile:filePath atomically:YES];
    
    __weak typeof(self) wself = self;
    [self.superVC dismissViewControllerAnimated:YES completion:^{
        if ([wself.delegate respondsToSelector:@selector(popMenu:didFinishPickImage:)]) {
            [wself.delegate popMenu:wself didFinishPickImage:editImage];
        }
    }];
}
@end
