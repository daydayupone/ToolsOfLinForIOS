//
//  Student.m
//  ui007
//
//  Created by 颜振洋 on 13-5-22.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "Student.h"
#import "ConnectionDB.h"
@implementation Student

+(NSMutableArray*)findall{
    NSMutableArray*stuArray=nil;//返回的一组查询结果
    sqlite3*sql3=[ConnectionDB createDB];//获取数据连接
    //    声明sql语句对象
    sqlite3_stmt *st;
    //给载体sqlite3_stmt *st语句赋值为"select * from student"
    int p=sqlite3_prepare_v2(sql3, "select * from student", -1, &st, nil);
    if (p==SQLITE_OK) {//判断SQL语法的正确性
        stuArray=[[NSMutableArray alloc]init];
        while (sqlite3_step(st)==SQLITE_ROW) {//查回来有下一条语句
            Student*stu=[[Student alloc]init];
            stu.stuid=sqlite3_column_int(st,0);
            stu.stuname=[NSString stringWithCString:(char*)sqlite3_column_text(st,1) encoding:NSUTF8StringEncoding];
            stu.stuphone=[NSString stringWithCString:(char*)sqlite3_column_text(st,2) encoding:NSUTF8StringEncoding];//将每条纪录存入相关学生对象Stu，并将学生对象存入数组
            //--------查询头像数据--------------
            int bytes = sqlite3_column_bytes(st, 3);//获取二进制列的大小
            Byte * value = (Byte *)sqlite3_column_blob(st, 3);//获取字节
            if( value != NULL && bytes != 0 ){ 
                stu.stuhead=[NSData dataWithBytes:value length:bytes];//根据字节和二进制大小转换为data数据存入stuhead
            }
            [stuArray addObject:stu];
        }
    }
    sqlite3_finalize(st);//关闭语句对象
    return stuArray;
}
+(Student*)findid:(int)sid{//查询一个对象值
    Student *stu1=nil;
    sqlite3 *sql3=[ConnectionDB createDB];
    sqlite3_stmt *st;
    NSString *sqlStr=[NSString stringWithFormat:@"select * from student where stuid=%d",sid];
    if (sqlite3_prepare_v2(sql3, [sqlStr UTF8String], -1, &st, nil)==SQLITE_OK) {//判断SQL语法的正确性
        stu1=[[Student alloc]init];
        while (sqlite3_step(st)==SQLITE_ROW) {//查回来有下一条语句

            stu1.stuid=sqlite3_column_int(st,0);
            stu1.stuname=[NSString stringWithCString:(char*)sqlite3_column_text(st,1) encoding:NSUTF8StringEncoding];
            stu1.stuphone=[NSString stringWithCString:(char*)sqlite3_column_text(st,2) encoding:NSUTF8StringEncoding];//将每条纪录存入相关学生对象Stu，并将学生对象存入数组
        }
    }
    sqlite3_finalize(st);//关闭语句对象
    return stu1;
}
+(void)insertStuName:(NSString*)stuname andStuphone:(NSString*)stuphone andStuhead:(NSData*)img{//增加一条语句
    sqlite3 *sql3=[ConnectionDB createDB];
    sqlite3_stmt *st;
    if (sqlite3_prepare_v2(sql3, "insert into student(stuname,stuphone,stuhead)values(?,?,?)", -1, &st, nil)==SQLITE_OK) {//?,表示占位数据。
        sqlite3_bind_text(st, 1, [stuname UTF8String], -1,nil);//绑定第一个问号语句
        sqlite3_bind_text(st, 2, [stuphone UTF8String], -1,nil);//绑定第二个问号语句
        sqlite3_bind_blob(st, 3, [img bytes], [img length], NULL);
    
        sqlite3_step(st);//执行sql
    }
    sqlite3_finalize(st);//关闭语句对象
}
+(void)updateStuName:(NSString*)stuname andStuphone:(NSString*)stuphone andid:(int)sid{//更新数据
    sqlite3 *sql3=[ConnectionDB createDB];
    sqlite3_stmt *st;
    if (sqlite3_prepare_v2(sql3, "update student set stuname=?,stuphone=? where stuid=?", -1, &st, nil)==SQLITE_OK) {//?,表示占位数据。
        sqlite3_bind_text(st, 1, [stuname UTF8String], -1,nil);//绑定第一个问号语句
        sqlite3_bind_text(st, 2, [stuphone UTF8String], -1,nil);//绑定第二个问号语句
        sqlite3_bind_int(st, 3, sid);//绑定第二个问号语句
        sqlite3_step(st);//执行sql
    }
    sqlite3_finalize(st);//关闭语句对象
}
+(void)deleteStudentWithId:(int)sid{//删除对象
    sqlite3 *sql3=[ConnectionDB createDB];//创建连接
    sqlite3_stmt *st;//声明语句对象
    NSString *sqlStr=[NSString stringWithFormat:@"delete from student where stuid=%d",sid];//
    if (sqlite3_prepare_v2(sql3, [sqlStr UTF8String], -1, &st, nil)==SQLITE_OK) {//判断语法正确性
        sqlite3_step(st);//执行sql
    }
    sqlite3_finalize(st);//关闭语句对象
}
@end
