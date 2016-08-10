//
//  CZBook.h
//  多任务下载
//
//  Created by xmy on 16/8/10.
//  Copyright © 2016年 xmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZBook : NSObject
/**
 *  标题
 */
@property(copy,nonatomic)NSString *name;
/**
 *  封面
 */
@property(copy,nonatomic)NSString *cover;
/**
 *  下载地址
 */
@property(copy,nonatomic)NSString *path;

@end
