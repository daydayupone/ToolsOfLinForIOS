//
//  Book.m
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "Book.h"
#import "ConnectionDB.h"
@implementation Book
@synthesize bookId,bookName,bookPublisher,bookPublishDate,bookAuthor,bookFaceImage,bookIntro;
#pragma mark - 查找
+(NSMutableArray*)findAll{
    NSMutableArray *bookArray=nil;
    sqlite3 *sql3=[ConnectionDB createDB];
 
    sqlite3_stmt *st;
  
    int p= sqlite3_prepare_v2(sql3, "select *from book", -1, &st , nil);
    
    if (p==SQLITE_OK) {
        bookArray=[[NSMutableArray alloc]init];
        
        while (sqlite3_step(st)==SQLITE_ROW) {
            Book *book=[[Book alloc]init];
            book.bookId=sqlite3_column_int(st, 0);
            
            book.bookName=[NSString stringWithCString:(char *)sqlite3_column_text(st, 1) encoding:NSUTF8StringEncoding];
            book.bookPublisher=[NSString stringWithCString:(char *)sqlite3_column_text(st, 2) encoding:NSUTF8StringEncoding];
            
            book.bookPublishDate=[NSString stringWithCString:(char *)sqlite3_column_text(st, 3) encoding:NSUTF8StringEncoding];
            
            book.bookAuthor=[NSString stringWithCString:(char *)sqlite3_column_text(st, 4) encoding:NSUTF8StringEncoding];
            
            
            int length=sqlite3_column_bytes(st, 5);
            Byte *imageByte=(Byte *)sqlite3_column_blob(st, 5);
            NSData *imageData=[NSData dataWithBytes:imageByte length:length];
            book.bookFaceImage=[[UIImage alloc]initWithData:imageData];
            
            book.bookIntro=[NSString stringWithCString:(char *)sqlite3_column_text(st, 6) encoding:NSUTF8StringEncoding];
            
            
            [bookArray addObject:book];
        }
    }
    sqlite3_finalize(st);
    
    return bookArray;
}

#pragma mark - 插入
+(void)insertWithName:(NSString *)name andPublisher:(NSString *)publisher andDate:(NSString *)publisherDate andAuthor:(NSString *)author andfaceImage:(UIImage *)faceImage andIntro:(NSString *)intro{
    NSData *data=UIImagePNGRepresentation(faceImage);//图片转NSData
   
    sqlite3 *sql3=[ConnectionDB createDB];
    
    NSString *sql=@"insert into book (bookname,bookpulisher,bookdate,bookauthor,bookface,bookintro) values (?,?,?,?,?,?)";
    sqlite3_stmt *st;
    
    if (sqlite3_prepare_v2(sql3, [sql UTF8String], -1, &st, nil)==SQLITE_OK) {
        sqlite3_bind_text(st, 1, [name UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_text(st, 2, [publisher UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_text(st, 3, [publisherDate UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_text(st, 4, [author UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_blob(st, 5, [data bytes], [data length], SQLITE_STATIC);
        sqlite3_bind_text(st, 6, [intro UTF8String], -1, SQLITE_STATIC);
        
        
        if (sqlite3_step(st)==SQLITE_ERROR) {
            NSLog(@"error:failed in kit update database");
        }
        
    }else{
        NSLog(@"sql语法错误");
    }
    sqlite3_finalize(st);
}


#pragma mark - 删除
+(void)deleteWithId:(int)bookId{
    sqlite3 *sql3=[ConnectionDB createDB];
    
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
#pragma mark - 用于收藏夹数据库的方法
#pragma mark - 查找收藏夹的所有book的方法
+(NSMutableArray*)findAllFavorite{
    NSMutableArray *bookArray=nil;
    sqlite3 *sql3=[ConnectionDB createFavorateDB];
    
    sqlite3_stmt *st;
    
    int p= sqlite3_prepare_v2(sql3, "select *from book", -1, &st , nil);
    
    if (p==SQLITE_OK) {
        bookArray=[[NSMutableArray alloc]init];
        
        while (sqlite3_step(st)==SQLITE_ROW) {
            Book *book=[[Book alloc]init];
            book.bookId=sqlite3_column_int(st, 0);
            
            book.bookName=[NSString stringWithCString:(char *)sqlite3_column_text(st, 1) encoding:NSUTF8StringEncoding];
            book.bookPublisher=[NSString stringWithCString:(char *)sqlite3_column_text(st, 2) encoding:NSUTF8StringEncoding];
            
            book.bookPublishDate=[NSString stringWithCString:(char *)sqlite3_column_text(st, 3) encoding:NSUTF8StringEncoding];
            
            book.bookAuthor=[NSString stringWithCString:(char *)sqlite3_column_text(st, 4) encoding:NSUTF8StringEncoding];
            
            
            int length=sqlite3_column_bytes(st, 5);
            Byte *imageByte=(Byte *)sqlite3_column_blob(st, 5);
            NSData *imageData=[NSData dataWithBytes:imageByte length:length];
            book.bookFaceImage=[[UIImage alloc]initWithData:imageData];
            
            book.bookIntro=[NSString stringWithCString:(char *)sqlite3_column_text(st, 6) encoding:NSUTF8StringEncoding];
            
            
            [bookArray addObject:book];
        }
    }
    sqlite3_finalize(st);
    
    return bookArray;
    
}

#pragma mark - 插入收藏夹
+(void)putIntoFavoriteWithBook:(Book *)book{
    NSData *data=UIImagePNGRepresentation(book.bookFaceImage);//图片转NSData
    
    sqlite3 *sql3=[ConnectionDB createFavorateDB];
    
    NSString *sql=@"insert into book (bookname,bookpulisher,bookdate,bookauthor,bookface,bookintro) values (?,?,?,?,?,?)";
    sqlite3_stmt *st;
    
    if (sqlite3_prepare_v2(sql3, [sql UTF8String], -1, &st, nil)==SQLITE_OK) {
        sqlite3_bind_text(st, 1, [book.bookName UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_text(st, 2, [book.bookPublisher UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_text(st, 3, [book.bookPublishDate UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_text(st, 4, [book.bookAuthor UTF8String], -1, SQLITE_STATIC);
        sqlite3_bind_blob(st, 5, [data bytes], [data length], SQLITE_STATIC);
        sqlite3_bind_text(st, 6, [book.bookIntro UTF8String], -1, SQLITE_STATIC);
        
        
        if (sqlite3_step(st)==SQLITE_ERROR) {
            NSLog(@"error:failed in kit update database");
        }
        
    }else{
        NSLog(@"sql语法错误");
    }
    sqlite3_finalize(st);
}

#pragma mark - 收藏夹删除
+(void)deleteFavoriteWithId:(int)bookId{
    sqlite3 *sql3=[ConnectionDB createFavorateDB];
    
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


@end
