//
//  Pre.h
//  CosChat
//
//  Created by Mark on 15/5/3.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#ifndef CosChat_Pre_h
#define CosChat_Pre_h

#define iPhone4  (int)[UIScreen mainScreen].bounds.size.height==480
#define iPhone5  (int)[UIScreen mainScreen].bounds.size.height==568
#define iPhone6  (int)[UIScreen mainScreen].bounds.size.height==667
#define iPhone6p (int)[UIScreen mainScreen].bounds.size.height==736
#define kNormalColor   [UIColor colorWithRed:27.0/255.0 green:188.0/255.0 blue:155.0/255.0 alpha:1.0]
#define kSelectedColor [UIColor colorWithRed:22.0/255.0 green:160.0/255.0 blue:134.0/255.0 alpha:1.0]

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
// Next Button size
#define kNextMargin 39
#define kNextHeight 40
#define kNextBMargin 129

#define kRoleInfoKey @"roleInfo"
#define kRoleFileName @"roleInfo.archiver"
#endif
