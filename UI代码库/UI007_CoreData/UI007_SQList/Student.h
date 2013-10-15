//
//  Student.h
//  UI007_SQList
//
//  Created by ibokan on 13-5-22.
//  Copyright (c) 2013年 Name. All rights reserved.
//


//实现代码与数据列表的映射
#import <Foundation/Foundation.h>

@interface Student : NSObject

//初步实现与学生表的映射
@property (assign,nonatomic) int stuid;
@property (retain,nonatomic) NSString *stuname;
@property (retain,nonatomic) NSString *stuphone;
@property (retain,nonatomic) NSData *stuhead;

//定义一个全表查询方法。因为查询的是表，表内存在多个对象，因此返回的通常是数组类型
+ (NSMutableArray *)findAll;

//根据主键查询单值方法
+ (Student *)findID:(int) sid;

//
+ (void) addStudentWithName:(NSString *)nm andPhone:(NSString *)ph;

//
+ (void) updateStudentWithName:(NSString *)nm andPhone:(NSString *) ph andId:(int) stid;//根据学员编号将进行更新

+ (void) deleteStundentWithId:(int) sid;

+ (NSData *) loadImage:(int) sid;

@end
