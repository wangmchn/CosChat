//
//  ChatModel.m
//  UUChatTableView
//
//  Created by shake on 15/1/6.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "ChatModel.h"
#import "UUMessageFrame.h"
#import <FMDB.h>
#import "NSString+filePath.h"
#define kDefaultLimit 20
#define DATABASE_FILENAME_RECORDS @"records.sqlite"
@interface ChatModel ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation ChatModel

static NSString *previousTime = nil;
- (instancetype)init{
    if (self == [super init]) {
        NSString *filePath = [NSString documentPathWithFileName:DATABASE_FILENAME_RECORDS];
        self.db = [[FMDatabase alloc] initWithPath:filePath];
        [self.db open];
        // 创建数据库
        [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS chat_records(id integer PRIMARY KEY, fromType integer CHECK (fromType in (100,101)), messageType integer CHECK (messageType in (0,1,2)), icon text,name text, content text, pic text,voice text, voiceTime text, showLabel integer)"];
        
    }
    return self;
}
- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
- (NSInteger)maxCountLimit{
    if (_maxCountLimit == 0) {
        _maxCountLimit = kDefaultLimit;
    }
    return _maxCountLimit;
}
#pragma mark - Public Methods
- (void)addTextMessageWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName strContent:(NSString *)strContent from:(MessageFrom)from{
    UUMessage *message = [[UUMessage alloc] initWithIcon:strIcon strId:strId time:strTime name:strName from:from];
    // text
    message.strContent = strContent;
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc] init];
    [messageFrame setMessage:message];
    [message minuteOffSetStart:previousTime end:strTime];
    
    [self.items addObject:messageFrame];
    
}
- (void)addPictureMessageWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName picture:(UIImage *)picture from:(MessageFrom)from{
    UUMessage *message = [[UUMessage alloc] initWithIcon:strIcon strId:strId time:strTime name:strName from:from];
    // picture
    message.picture = picture;
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc] init];
    [messageFrame setMessage:message];
    [message minuteOffSetStart:previousTime end:strTime];
    
    [self.items addObject:messageFrame];
}
- (void)addVoiceMessageWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName voice:(NSData *)voice strVoiceTime:(NSString *)strVoiceTime from:(MessageFrom)from{
    UUMessage *message = [[UUMessage alloc] initWithIcon:strIcon strId:strId time:strTime name:strName from:from];
    // voice
    message.voice = voice;
    message.strVoiceTime = strVoiceTime;
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc] init];
    [messageFrame setMessage:message];
    [message minuteOffSetStart:previousTime end:strTime];
    
    [self.items addObject:messageFrame];
}
- (void)loadMoreMessageFromDatabase:(RecordsLoadCompletionBlock)done{
    
    done();
}
#pragma mark - Private
- (void)maintainLowMemoryCost{
    if (self.items.count <= self.maxCountLimit) return;
    
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            UUMessageFrame *messageFrame = (UUMessageFrame *)wself.items[0];
            [wself.items removeObjectAtIndex:0];
            // write to file...
            // ....
            
            
            
        }
    });
    
}
- (void)writeMessageToDB:(UUMessage *)message{
    switch (message.type) {
        case UUMessageTypeText:
            [self.db executeUpdateWithFormat:@"INSERT INTO chat_records(fromType,messageType,icon,name,content,time,show) VALUES(%d,%d,%@,%@,%@,%@,%d)",message.from,message.type,message.strIcon,message.strName,message.strContent,message.strTime,message.showDateLabel];
            break;
        case UUMessageTypePicture:
            [self.db executeUpdateWithFormat:@"INSERT INTO chat_records(fromType,messageType,icon,name,pic,time,show) VALUES(%d,%d,%@,%@,%@,%@,%d)",message.from,message.type,message.strIcon,message.strName,message.picture,message.strTime,message.showDateLabel];
            break;
        case UUMessageTypeVoice:
            [self.db executeUpdateWithFormat:@"INSERT INTO chat_records(fromType,messageType,icon,name,voice,voiceTime,time,show) VALUES(%d,%d,%@,%@,%@,%@,%@,%d)",message.from,message.type,message.strIcon,message.strName,message.strTime,message.strVoiceTime,message.strTime,message.showDateLabel];
            break;
        default:
            break;
    }
}
@end
