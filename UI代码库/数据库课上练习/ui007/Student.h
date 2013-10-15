//
//  Student.h
//  ui007
//
//  Created by 颜振洋 on 13-5-22.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property(assign,nonatomic)int stuid;
@property(retain,nonatomic)NSString*stuname;
@property(retain,nonatomic)NSString*stuphone;
@property(retain,nonatomic)NSData*stuhead;
+(NSMutableArray*)findall;//常见的全表查询方法
+(Student*)findid:(int)sid;//根据主键查询单值
+(void)insertStuName:(NSString*)stuname andStuphone:(NSString*)stuphone;//添加一条对象
+(void)updateStuName:(NSString*)stuname andStuphone:(NSString*)stuphone andid:(int)stid;//更新一条对象
+(void)deleteStudentWithId:(int)sid;
+(void)insertStuName:(NSString*)stuname andStuphone:(NSString*)stuphone andStuhead:(NSData*)img;
@end
