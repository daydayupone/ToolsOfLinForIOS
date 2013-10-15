//
//  Web.m
//  Safari
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "Web.h"
#import "Connection.h"

@implementation Web

//读取数据库的所有存储文件
+(NSMutableArray *)findAll{
    NSMutableArray *webArray=nil;//返回的查询结果
    
    sqlite3 *sql3=[Connection shareConnect];//返回一个指针类型
    
    //声明sql语句对象
    sqlite3_stmt *st;
    
    //给sql语句对象赋值
    //第三项 -1，指取第二项字符串的全部长度。第四项 可以写回调函数
    int p= sqlite3_prepare_v2(sql3, "select *from web", -1, &st , nil);
    
    if (p==SQLITE_OK) {//判断sql语法正确性
        webArray=[[NSMutableArray alloc]init];
        
        while (sqlite3_step(st)==SQLITE_ROW) {//是否查询到记录
            Web *wb =[[Web alloc]init];
            
            wb.webid = (int*)sqlite3_column_int(st, 0);
            
            wb.weburl = [NSString stringWithCString:(char *)sqlite3_column_text(st, 1) encoding:NSUTF8StringEncoding];
            wb.webname = [NSString stringWithCString:(char *)sqlite3_column_text(st, 2) encoding:NSUTF8StringEncoding] ;
            
            int length=sqlite3_column_bytes(st, 3);
            Byte *imageByte=(Byte *)sqlite3_column_blob(st, 3);
            wb.webimage = [NSData dataWithBytes:imageByte length:length];
        
            [webArray addObject:wb];
        }
    }
    sqlite3_finalize(st);
    
    return webArray;
    
}




+ (void)  andUrl:(NSString *)webUrl andName:(NSString *)webName andImage:(NSData *) webImage{
    sqlite3 *sql3 = [Connection shareConnect];//获取数据连接
    //声明SQL语句的对象
    sqlite3_stmt *st;
    //给sql语句对象赋值为“insert into student (stuname,stuphone) values(?,?)”
    int p = sqlite3_prepare_v2(sql3, "insert into web (weburl,webname,webimage) values(?,?,?)", -1, &st, nil);
    
    if (p == SQLITE_OK) {//判断SQL语法的正确性
        //绑定SQL语句,给第一个？传值
//        sqlite3_bind_int(st, 1, webId);
        //绑定SQL语句,给第二个？传值
        sqlite3_bind_text(st/*希望绑定的语句对象*/, 1/*列2*/, [webUrl/*传的参数*/ UTF8String], -1, nil);
        sqlite3_bind_text(st, 2, [webName UTF8String], -1, nil);
    
        sqlite3_bind_blob(st, 3, [webImage bytes], [webImage length], nil);
        
        //执行sql
        sqlite3_step(st);
    }
    sqlite3_finalize(st);//关闭连接
}


@end
