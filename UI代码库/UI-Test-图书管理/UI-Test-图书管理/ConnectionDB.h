//
//  ConnectionDB.h
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface ConnectionDB : NSObject
//获取可用的数据连接对象
+(sqlite3 *)createDB;

+(sqlite3 *)createFavorateDB;
@end
