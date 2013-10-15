//
//  Connection.m
//  Safari
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "Connection.h"
static sqlite3 * sql = nil;
@implementation Connection



+(sqlite3 *) shareConnect{
    
    if (sql != nil) {
        return sql;
    }
    
    //获得数据库的源路径
    NSString *sourcePath = [[NSBundle mainBundle]pathForResource:@"weblist" ofType:@"sqlite"];
    
    //返回Documents目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];//注意：NSDocumentDirectory不要用NSDocumentationDirectory
    
    //和之前的文件路径拼接，形成一个完整的路径
    NSString *targetPath = [docPath stringByAppendingPathComponent:@"weblist.sqlite"];
    //
    NSLog(@"targetPath = %@",targetPath);
    
    //创建文件的管理者
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error = nil;//创建一个用于存储错误信息的
    
    //判断目录下文件是否存在
    if (![fm fileExistsAtPath:targetPath]) {
        if ([fm copyItemAtPath:sourcePath toPath:targetPath error:&error]) {
            NSLog(@"拷贝文件成功");
        }
        else
        {
            NSLog(@"error = %@",error);
            return sql;//
            
        }
    }
    //开启SQListe中的数据
    sqlite3_open([targetPath UTF8String]/*将OC的数据类型转换为C能够辨别的类型*/, &sql);
    NSLog(@"instance %p",sql);//instanc是指针，使用%p打印内存地址
    
    return sql;
}


@end
