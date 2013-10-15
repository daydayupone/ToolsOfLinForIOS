//
//  ConnectionDB.h
//  ui007
//
//  Created by 颜振洋 on 13-5-22.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface ConnectionDB : NSObject
+(sqlite3*)createDB;//获取可用的数据连接对象
@end
