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

#define CREATE_TABLE_SQL @"CREATE TABLE IF NOT EXISTS chat_records(id integer PRIMARY KEY, fromType integer CHECK (fromType in (100,101)), messageType integer CHECK (messageType in (0,1,2)), icon text,name text, content text, pic text,voice text, voiceTime text, showLabel integer,`timestamp` BIGINT NOT NULL,)"

//#define CREATE_MSG_TABLE_SQL @"CREATE TABLE IF NOT EXISTS `msgs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `msg_id` VARCHAR(64) NOT NULL,`convid` VARCHAR(64) NOT NULL,`object` BLOB,`timestamp` BIGINT NOT NULL, `type` INT NOT NULL, `from` VARCHAT(64), `toClients` BLOB)"
//
//#define CREATE_MSG_UNIQUE_INDEX_SQL @"CREATE UNIQUE INDEX IF NOT EXISTS `msg_index` ON `msgs` (`convid`,`timestamp`,`msg_id`)"

#define INSERT_MSG_SQL @"INSERT INTO `msgs`(`msg_id`, `convid`, `object`, `timestamp`, `type`, `from`, `toClients`) VALUES(?, ?, ?, ?, ?, ?, ?)"

#define QUERY_MSG_SQL @"SELECT * from msgs where convid=? and timestamp<? order by timestamp limit ?"

#define DATABASE_FILENAME_RECORDS @"records.sqlite"
@interface ChatModel ()
@property (nonatomic, strong) FMDatabaseQueue *queue;
@end

@implementation ChatModel

static NSString *previousTime = nil;
- (instancetype)init{
    if (self == [super init]) {
        NSString *filePath = [NSString documentPathWithFileName:DATABASE_FILENAME_RECORDS];
        // 创建数据库
        self.queue = [[FMDatabaseQueue alloc] initWithPath:filePath];
        [self.queue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:CREATE_TABLE_SQL];
        }];
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
    message.type = UUMessageTypeText;
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc] init];
    [message minuteOffSetStart:previousTime end:strTime];
    previousTime = strTime;
    
    [messageFrame setMessage:message];
    [self.items addObject:messageFrame];
    
}
- (void)addPictureMessageWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName picture:(UIImage *)picture from:(MessageFrom)from{
    UUMessage *message = [[UUMessage alloc] initWithIcon:strIcon strId:strId time:strTime name:strName from:from];
    // picture
    message.picture = picture;
    message.type = UUMessageTypePicture;
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc] init];
    [message minuteOffSetStart:previousTime end:strTime];
    previousTime = strTime;
    
    [messageFrame setMessage:message];
    [self.items addObject:messageFrame];
}
- (void)addVoiceMessageWithIcon:(NSString *)strIcon strId:(NSString *)strId time:(NSString *)strTime name:(NSString *)strName voice:(NSData *)voice strVoiceTime:(NSString *)strVoiceTime from:(MessageFrom)from{
    UUMessage *message = [[UUMessage alloc] initWithIcon:strIcon strId:strId time:strTime name:strName from:from];
    // voice
    message.voice = voice;
    message.strVoiceTime = strVoiceTime;
    message.type = UUMessageTypeVoice;
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc] init];
    [message minuteOffSetStart:previousTime end:strTime];
    [message minuteOffSetStart:previousTime end:strTime];
    previousTime = strTime;
    
    [messageFrame setMessage:message];
    [self.items addObject:messageFrame];
}
- (void)loadMoreMessageFromDatabase:(RecordsLoadCompletionBlock)done{
    // load data from db...
    done();
}
#pragma mark - Private
- (void)maintainLowMemoryCost{
    if (self.items.count <= self.maxCountLimit) return;
    
    UUMessage *message = [(UUMessageFrame *)self.items[0] message];
    [self.items removeObjectAtIndex:0];
    // write to file...
    
//    [self writeMessageToDB:message];
//    __weak typeof(self) wself = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @autoreleasepool {
//            UUMessageFrame *messageFrame = (UUMessageFrame *)wself.items[0];
//            [wself.items removeObjectAtIndex:0];
//            // write to file...
//            // ....
//            
//            
//            
//        }
//    });
    
}
//- (void)writeMessageToDB:(UUMessage *)message{
//    switch (message.type) {
//        case UUMessageTypeText:
//            [self.db executeUpdateWithFormat:@"INSERT INTO chat_records(fromType,messageType,icon,name,content,time,show) VALUES(%d,%d,%@,%@,%@,%@,%d)",message.from,message.type,message.strIcon,message.strName,message.strContent,message.strTime,message.showDateLabel];
//            break;
//        case UUMessageTypePicture:
//            [self.db executeUpdateWithFormat:@"INSERT INTO chat_records(fromType,messageType,icon,name,pic,time,show) VALUES(%d,%d,%@,%@,%@,%@,%d)",message.from,message.type,message.strIcon,message.strName,message.picture,message.strTime,message.showDateLabel];
//            break;
//        case UUMessageTypeVoice:
//            [self.db executeUpdateWithFormat:@"INSERT INTO chat_records(fromType,messageType,icon,name,voice,voiceTime,time,show) VALUES(%d,%d,%@,%@,%@,%@,%@,%d)",message.from,message.type,message.strIcon,message.strName,message.strTime,message.strVoiceTime,message.strTime,message.showDateLabel];
//            break;
//        default:
//            break;
//    }
//}
@end
