//
//  ConnectionDB.m
//  Ui008图书管理系统
//
//  Created by ibokan on 13-5-24.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "ConnectionDB.h"

@implementation ConnectionDB

static sqlite3 *instanc=nil;
+(sqlite3 *)createDB{
    if (instanc !=nil) {
        return instanc;
    }
    
    //数据路径的原路径  用于要把bundle里的数据库拷贝到doucument里 因为bundle里面的不能够修改
    NSString *sourcePath=[[NSBundle mainBundle]pathForResource:@"booksdb" ofType:@"sqlite"];
    //获取document目录路径  c函数返回数组
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //会以目录的形式 分割下字符串 带有分隔符/
    NSString *targetPath=[docPath stringByAppendingPathComponent:@"booksdb.sqlite"];
    
    NSLog(@"targetPath=%@",targetPath);
    
    //文件管理器
    NSFileManager *fm=[NSFileManager defaultManager];
    NSError *error=nil;
    
    if (![fm fileExistsAtPath:targetPath]) {
        if ([fm copyItemAtPath:sourcePath toPath:targetPath error:&error]) {
            NSLog(@"拷贝成功");
        }else{
            NSLog(@"拷贝失败 error=%@",error);
            return instanc;
        }
    }
    
    //oc 字符串转换为 c的字符串指针   创建连接
    sqlite3_open([targetPath UTF8String], &instanc);//执行完此句 后
    NSLog(@"instanc=%p",instanc);
    
    return instanc;
    
}


@end
