//
//  Student.m
//  UI007_SQList
//
//  Created by ibokan on 13-5-22.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "Student.h"
#import "ConnectionDB.h"

@implementation Student

//读取图片
+(NSData *)loadImage:(int) sid
{
    //存储数据用的NSData数据类型
    NSData *data = nil;
    //获取数据连接
    sqlite3 *sql3 = [ConnectionDB createDB];
    //声明SQL语句的对象
    sqlite3_stmt *st;
    NSString* chaNumber = [NSString stringWithFormat:@"SELECT stuhead FROM student WHERE stuid = %d", sid];
    
    
    if( sqlite3_prepare_v2(sql3, [chaNumber UTF8String], -1, &st, NULL) == SQLITE_OK )
    {
        int length = sqlite3_column_bytes(st, 3);//获取二进制数据的长度
        Byte *value = (Byte *)sqlite3_column_blob(st, 3);//获取数据的字节
        if( sqlite3_step(st) == SQLITE_ROW )
        {
            data = [NSData dataWithBytes:value length:length];//由长度、字节构成二进制大的数据
        }
    }
    
    // Finalize and close database.
    sqlite3_finalize(st);
    
    return data;
}

//删除语法
+ (void) deleteStundentWithId:(int) sid
{
    
    sqlite3 *sql3 = [ConnectionDB createDB];//获取数据连接
    //声明SQL语句的对象
    sqlite3_stmt *st;

    //给SQL语句对象赋值为"select *from student"
    NSString *chaNumber = [NSString stringWithFormat:@"delete from student where stuid = %d",sid];//获得代码为sid的所有数据
    
    //    int p = sqlite3_prepare_v2(sql3, "select stuid from student"/*我们查询的语句*/, -1/*SQL语句的长度，-1时候系统自动计算*/, &st, nil/*此处往往提供的是一个函数指针，但可以置空*/);
    int p = sqlite3_prepare_v2(sql3, [chaNumber UTF8String], -1, &st, nil);
    
    if (p == SQLITE_OK) {//判断SQL语法的正确性
        
        sqlite3_step(st);            
    
    }
    
    sqlite3_finalize(st);//关闭连接
    
}

//添加
+ (void) addStudentWithName:(NSString *)nm andPhone:(NSString *)ph
{
    sqlite3 *sql3 = [ConnectionDB createDB];//获取数据连接
    //声明SQL语句的对象
    sqlite3_stmt *st;
    //给sql语句对象赋值为“insert into student (stuname,stuphone) values(?,?)”
    int p = sqlite3_prepare_v2(sql3, "insert into student (stuname,stuphone) values(?,?)", -1, &st, nil);
    
    if (p == SQLITE_OK) {//判断SQL语法的正确性
        //绑定SQL语句,给第一个？传值
        sqlite3_bind_text(st/*希望绑定的语句对象*/, 1/*列1*/, [nm/*传的参数*/ UTF8String], -1, nil);
        //绑定SQL语句,给第二个？传值
        sqlite3_bind_text(st/*希望绑定的语句对象*/, 2/*列2*/, [ph/*传的参数*/ UTF8String], -1, nil);
        //执行sql
        sqlite3_step(st);
    }
    sqlite3_finalize(st);//关闭连接
}

//更新
+ (void) updateStudentWithName:(NSString *)nm andPhone:(NSString *) ph andId:(int) stid
{
    sqlite3 *sql3 = [ConnectionDB createDB];//获取数据连接
    //声明SQL语句的对象
    sqlite3_stmt *st;
    //给sql语句对象赋值为“updata into student (stuname,stuphone) values(?,?)”
    int p = sqlite3_prepare_v2(sql3, "update student set stuname = ? ,stuphone=? where stuid =?", -1, &st, nil);
    
    if (p == SQLITE_OK) {//判断SQL语法的正确性
        //绑定SQL语句,给第一个？传值
        sqlite3_bind_text(st/*希望绑定的语句对象*/, 1/*列1*/, [nm UTF8String], -1, nil);
        //绑定SQL语句,给第二个？传值
        sqlite3_bind_text(st/*希望绑定的语句对象*/, 2/*列2*/, [ph UTF8String], -1, nil);
        //绑定传值的ID
        sqlite3_bind_int(st, 3, stid);
        //执行sql
        sqlite3_step(st);
    }
    sqlite3_finalize(st);//关闭连接
}
//定义一个全表查询方法。因为查询的是表，表内存在多个对象，因此返回的通常是数组类型
+ (NSMutableArray *)findAll
{
    NSMutableArray *stuArray = nil;//返回的查询结果
    
    sqlite3 *sql3 = [ConnectionDB createDB];//获取数据连接
    //声明SQL语句的对象
    sqlite3_stmt *st;
    //给SQL语句对象赋值为"select *from student"
    int p = sqlite3_prepare_v2(sql3, "select *from student"/*我们查询的语句*/, -1/*SQL语句的长度，-1时候系统自动计算*/, &st, nil/*此处往往提供的是一个函数指针，但可以置空*/);
    
    if (p == SQLITE_OK) {//判断SQL语法的正确性
        
        stuArray = [[NSMutableArray alloc]init];//SQL语法正确，就为可变数组开辟一个空间
        
        while (sqlite3_step(st)==SQLITE_ROW/*查询到是否有记录，有记录时执行*/) {
            
            Student *stu = [[Student alloc]init];//创建学生对象
            
            /*sqlite3_column_int(st, 0)取出SQL表里第一列的整形的数数据
             *sqlite3_column_text(st, 1)取出SQL表里第二列的字符串类型的数据
             *sqlite3_column_text(st, 2)取出SQL表里第三列的字符串类型的数据
             */
            stu.stuid = sqlite3_column_int(st, 0);//查询st对象的第一列的所有值，并且使用stu的stuid属性存储信息
            
            stu.stuname =[NSString stringWithCString: (char *)sqlite3_column_text(st, 1) encoding:NSUTF8StringEncoding];//sqlite3_column_int得出的数据类型是C语言的无符号字符指针类型的,因此需要进行一个数据类型的转换
            
            if (sqlite3_column_text(st, 2) !=nil) {//stu.stuphone
                stu.stuphone =[NSString stringWithCString: (char *)sqlite3_column_text(st, 2) encoding:NSUTF8StringEncoding];
            }
            
            //查询学生头像
            int bytes = sqlite3_column_bytes(st, 3);
            Byte *value = (Byte*)sqlite3_column_blob(st, 3);
            
            if (value!=NULL && bytes !=0) {//stu.stuphone
                
                stu.stuhead = [NSData dataWithBytes:value length:bytes];
            }
            
            
            [stuArray addObject:stu];//将每条记录存入相关学生对象stu，并且将学生对象存入数组stuArray
            
        }
    }
    
   //关闭SQL语句对象
    sqlite3_finalize(st);
    return stuArray;
}

//定义一个ID查询方法
+ (Student *)findID:(int) sid
{
    Student *stu = nil;//返回的查询结果
    
    sqlite3 *sql3 = [ConnectionDB createDB];//获取数据连接
    //声明SQL语句的对象
    sqlite3_stmt *st;
    //给SQL语句对象赋值为"select *from student"
    NSString *chaNumber = [NSString stringWithFormat:@"select * from student where stuid = %d",sid];//获得代码为sid的所有数据
    
//    int p = sqlite3_prepare_v2(sql3, "select stuid from student"/*我们查询的语句*/, -1/*SQL语句的长度，-1时候系统自动计算*/, &st, nil/*此处往往提供的是一个函数指针，但可以置空*/);
    int p = sqlite3_prepare_v2(sql3, [chaNumber UTF8String], -1, &st, nil);

    
    if (p == SQLITE_OK) {//判断SQL语法的正确性
        
        stu = [[Student alloc]init];//SQL语法正确，就为可变数组开辟一个空间
        
        while (sqlite3_step(st)==SQLITE_ROW/*查询到是否有记录，有记录时执行*/) {
            
//            Student *stu = [[Student alloc]init];//创建学生对象
            
            stu.stuid = sqlite3_column_int(st, 0);//查询st对象的第一列的所有值，并且使用stu的stuid属性存储信息
            
            stu.stuname =[NSString stringWithCString: (char *)sqlite3_column_text(st, 1) encoding:NSUTF8StringEncoding];//sqlite3_column_int得出的数据类型是C语言的无符号字符指针类型的,因此需要进行一个数据类型的转换
           // if (stu.stuphone ==nil) {//stu.stuphone
                stu.stuphone =[NSString stringWithCString: (char *)sqlite3_column_text(st, 2) encoding:NSUTF8StringEncoding];
            //}
        }
    }
    //关闭SQL语句对象
    sqlite3_finalize(st);
    return stu;
}





@end
