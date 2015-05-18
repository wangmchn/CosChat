//
//  ChatModel.h
//  UUChatTableView
//
//  Created by shake on 15/1/6.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UUMessage.h"
typedef void(^RecordsLoadCompletionBlock)();

@interface ChatModel : NSObject
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSInteger maxCountLimit;
// Text
- (void)addTextMessageWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName strContent:(NSString *)strContent from:(MessageFrom)from;

// Picture
- (void)addPictureMessageWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName picture:(UIImage *)picture from:(MessageFrom)from;

// Voice
- (void)addVoiceMessageWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName voice:(NSData *)voice strVoiceTime:(NSString *)strVoiceTime from:(MessageFrom)from;

- (void)loadMoreMessageFromDatabase:(RecordsLoadCompletionBlock)done;
@end
