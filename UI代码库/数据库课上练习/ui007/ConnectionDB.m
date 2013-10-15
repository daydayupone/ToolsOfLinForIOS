//
//  ConnectionDB.m
//  ui007
//
//  Created by 颜振洋 on 13-5-22.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "ConnectionDB.h"

@implementation ConnectionDB
static sqlite3*instanc=nil;
+(sqlite3*)createDB{
    if (instanc!=nil) {
        return instanc;
    }
    NSString*sourcePath=[[NSBundle mainBundle]pathForResource:@"StudentDB" ofType:@"sqlite"];//获取数据库文件的源路径
    //数据库文件的目标路径
    NSString*docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];//返回一个绝对路径用来存储我们需要存储的文件
    NSString*targetPath=[docPath stringByAppendingPathComponent:@"StudentDB.sqlite"];
    NSLog(@"targetPath=%@",targetPath);
    NSFileManager*fm=[NSFileManager defaultManager];//单例对象管理这个文件的管理结构
    NSError*error=nil;
    //判断目录文件是否存在
    if (![fm fileExistsAtPath:targetPath]) {
        if ([fm copyItemAtPath:sourcePath toPath:targetPath error:&error]) {//BOOL型
            NSLog(@"拷贝成功");
        }else{
            NSLog(@"error=%@",error);
            return instanc;
        }
    }
    sqlite3_open([targetPath UTF8String], &instanc);
    NSLog(@"instanc=%p",instanc);
    return instanc;
}
@end
