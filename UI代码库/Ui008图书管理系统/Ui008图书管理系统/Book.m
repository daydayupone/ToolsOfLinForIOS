//
//  Book.m
//  Ui008图书管理系统
//
//  Created by ibokan on 13-5-24.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "Book.h"
#import "ConnectionDB.h"
@implementation Book
@synthesize bookId,bookName,bookPrice;
#pragma mark - 查找
+(NSMutableArray *)findAll{
    NSMutableArray *bookArray=nil;//返回的查询结果
    
    sqlite3 *sql3=[ConnectionDB createDB];//返回一个指针类型
    
    //声明sql语句对象
    sqlite3_stmt *st;
    
    //给sql语句对象赋值 
    //第三项 -1，指取第二项字符串的全部长度。第四项 可以写回调函数
    int p= sqlite3_prepare_v2(sql3, "select *from book", -1, &st , nil);
    
    if (p==SQLITE_OK) {//判断sql语法正确性
        bookArray=[[NSMutableArray alloc]init];
        
        while (sqlite3_step(st)==SQLITE_ROW) {//是否查询到记录
            Book *book=[[Book alloc]init];
            book.bookId=sqlite3_column_int(st, 0);
            
            book.bookName=[NSString stringWithCString:(char *)sqlite3_column_text(st, 1) encoding:NSUTF8StringEncoding];
            book.bookPrice=(float)sqlite3_column_double(st, 2);
            
            int length=sqlite3_column_bytes(st, 3);
            Byte *imageByte=(Byte *)sqlite3_column_blob(st, 3);
            NSData *imageData=[NSData dataWithBytes:imageByte length:length];
            book.faceImage=[[UIImage alloc]initWithData:imageData];
            
            [bookArray addObject:book];
        }
    }
    sqlite3_finalize(st);
    
    return bookArray;

}
#pragma mark - 插入
+(void)insertIntoSqlWithName:(NSString *)name andPrice:(float)price andImage:(UIImage *)image{
    NSData *data=UIImagePNGRepresentation(image);//图片转NSData
    sqlite3 *sql3=[ConnectionDB createDB];
    NSString *sql=@"insert into book (bookname,bookprice,bookface) values (?,?,?)";
    sqlite3_stmt *st;
    if (sqlite3_prepare_v2(sql3, [sql UTF8String], -1, &st, nil)==SQLITE_OK) {
        sqlite3_bind_text(st, 1, [name UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_double(st, 2, price);
        sqlite3_bind_blob(st, 3, [data bytes], [data length], nil);
        
        if (sqlite3_step(st)==SQLITE_ERROR) {
            NSLog(@"error:failed in kit update database");
        }
        
    }else{
        NSLog(@"sql语法错误");
    }
    sqlite3_finalize(st);
}
+(void)insertIntoSqlWithName:(NSString *)name andPrice:(float)price{
    sqlite3 *sql3=[ConnectionDB createDB];
    NSString *sql=@"insert into book (bookname,bookprice) values (?,?)";
    sqlite3_stmt *st;
    if (sqlite3_prepare_v2(sql3, [sql UTF8String], -1, &st, nil)==SQLITE_OK) {
        sqlite3_bind_text(st, 1, [name UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_double(st, 2, price);
      
        if (sqlite3_step(st)==SQLITE_ERROR) {
            NSLog(@"error:failed in kit update database");
        }
        
    }else{
        NSLog(@"sql语法错误");
    }
    sqlite3_finalize(st);
}

+(void)insertImage:(UIImage *)image WithId:(int)bookId{
    NSData *data=UIImagePNGRepresentation(image);//图片转NSData
    
    sqlite3 *sql3=[ConnectionDB createDB];
    NSString *sql=[NSString stringWithFormat:@"update book set bookface=? where bookId=%d",bookId];
    
  
    sqlite3_stmt *st;
    
    if(sqlite3_prepare_v2(sql3, [sql UTF8String], -1, &st, nil)==SQLITE_OK){
        
        sqlite3_bind_blob(st, 1, [data bytes], [data length], nil);//参数第二个是转bytes 第三个是长度
        
        if (sqlite3_step(st)==SQLITE_ERROR) {//绑定好参数之后 再执行sql
            NSLog(@"error:failed in kit updata database");
        }else{
            NSLog(@"正确执行了");
        }
    }else{
        NSLog(@"sql语法错误");
    }
    sqlite3_finalize(st);
}
#pragma mark - 删除

+(void)deleteACellFromDbWithId:(int)bookId{
    sqlite3 *sql3=[ConnectionDB createDB];//类似单例 的指针型
    
    NSString *sql=[NSString stringWithFormat:@"delete from book where bookid=%d",bookId ];
    
    sqlite3_stmt *st;
    if (sqlite3_prepare_v2(sql3, [sql UTF8String], -1, &st, nil)==SQLITE_OK) {
        if (sqlite3_step(st)==SQLITE_ERROR) {
            NSLog(@"error:failed in kit delete database");
        }
        
    }else{
        
        NSLog(@"sql语法错误");
    }
    sqlite3_finalize(st);

}


#pragma mark - 更新
+(void)updateName:(NSString *)newName andPrice:(float)price  withId:(int)bookId{
    sqlite3 *sql3=[ConnectionDB createDB];
    NSString *sql=[NSString stringWithFormat:@"update book set bookname=?,bookprice=? where bookid=?"];
    sqlite3_stmt *st;
    
    if(sqlite3_prepare_v2(sql3, [sql UTF8String], -1, &st, nil)==SQLITE_OK){
        
        sqlite3_bind_text(st, 1, [newName UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_double(st, 2, price);
        sqlite3_bind_int(st, 3, bookId);  
        
        if (sqlite3_step(st)==SQLITE_ERROR) {//绑定好参数之后 再执行sql
            
            NSLog(@"error:failed in kit updata database");
        }else{
            NSLog(@"正确执行了");
        }
    }else{
        NSLog(@"sql语法错误");
    }
    sqlite3_finalize(st);

}
+(void)updateName:(NSString *)newName andPrice:(float)price andImage:(UIImage *)newImage withId:(int)bookId{
    NSData *data=UIImagePNGRepresentation(newImage);
    sqlite3 *sql3=[ConnectionDB createDB];
    NSString *sql=[NSString stringWithFormat:@"update book set bookname=?,bookPrice=?,bookface=? where bookid=?"];
    sqlite3_stmt *st;
    
    if(sqlite3_prepare_v2(sql3, [sql UTF8String], -1, &st, nil)==SQLITE_OK){
        
        sqlite3_bind_text(st, 1, [newName UTF8String], -1, SQLITE_STATIC);//1，2是 sql 第几个参数？的意思
        sqlite3_bind_double(st, 2, price);
        
        sqlite3_bind_blob(st, 3, [data bytes], [data length], nil);
        sqlite3_bind_int(st, 4, bookId);
        
        if (sqlite3_step(st)==SQLITE_ERROR) {//绑定好参数之后 再执行sql
            
            NSLog(@"error:failed in kit updata database");
        }else{
            NSLog(@"更新正确执行了");
        }
    }else{
        NSLog(@"sql语法错误");
    }
    sqlite3_finalize(st);


}

@end
