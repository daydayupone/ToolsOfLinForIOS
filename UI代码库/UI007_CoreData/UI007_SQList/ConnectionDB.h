//
//  ConnectionDB.h
//  UI007_SQList
//
//  Created by ibokan on 13-5-22.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>//1、导入SQListe的框架

@interface ConnectionDB : NSObject

+ (sqlite3 *)createDB;//获取可用数据连接

@end
