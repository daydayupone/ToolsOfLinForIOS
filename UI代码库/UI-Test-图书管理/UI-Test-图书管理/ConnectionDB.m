//
//  ConnectionDB.m
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "ConnectionDB.h"

@implementation ConnectionDB
static sqlite3 *instanc=nil;
static sqlite3 *faInstanc=nil;
+(sqlite3 *)createDB{
    if (instanc !=nil) {
        return instanc;
    }
    
    NSString *sourcePath=[[NSBundle mainBundle]pathForResource:@"bookdb" ofType:@"sqlite"];
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *targetPath=[docPath stringByAppendingPathComponent:@"bookdb.sqlite"];
    NSLog(@"targetPath=%@",targetPath);
    
    NSFileManager *fm=[NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:targetPath]) {
        if ([fm copyItemAtPath:sourcePath toPath:targetPath error:nil]) {
            NSLog(@"拷贝成功");
        }else{
            NSLog(@"copy 失败");
        }
    }
    
    sqlite3_open([targetPath UTF8String], &instanc);
    NSLog(@"instanc=%p",instanc);
    
    return instanc;
   
}

+(sqlite3 *)createFavorateDB{
    if (faInstanc !=nil) {
        return faInstanc;
    }
    
    NSString *sourcePath=[[NSBundle mainBundle]pathForResource:@"favoritedb" ofType:@"sqlite"];
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *targetPath=[docPath stringByAppendingPathComponent:@"favoritedb.sqlite"];
    NSLog(@"targetPath=%@",targetPath);
    
    NSFileManager *fm=[NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:targetPath]) {
        if ([fm copyItemAtPath:sourcePath toPath:targetPath error:nil]) {
            NSLog(@"拷贝成功");
        }else{
            NSLog(@"copy 失败");
        }
    }
    
    sqlite3_open([targetPath UTF8String], &faInstanc);
    NSLog(@"faInstanc=%p",faInstanc);
    
    return faInstanc;
}
@end
