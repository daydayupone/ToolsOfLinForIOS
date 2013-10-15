//
//  ConnectionDB.h
//  Ui008图书管理系统
//
//  Created by ibokan on 13-5-24.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface ConnectionDB : NSObject

//获取可用的数据连接对象
+(sqlite3 *)createDB;
@end
