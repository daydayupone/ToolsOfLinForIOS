//
//  Book.h
//  Ui008图书管理系统
//
//  Created by ibokan on 13-5-24.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property(assign,nonatomic)int bookId;
@property(retain,nonatomic)NSString *bookName;
@property(assign,nonatomic)float bookPrice;
@property(retain,nonatomic)UIImage *faceImage;

+(NSMutableArray *)findAll;//查找全部

+(void)insertIntoSqlWithName:(NSString *)name andPrice:(float)price andImage:(UIImage *)image;
+(void)insertIntoSqlWithName:(NSString *)name andPrice:(float)price;//插入数据
+(void)insertImage:(UIImage *)image WithId:(int)bookId;//插入图片

+(void)deleteACellFromDbWithId:(int)bookId;//按id 删除数据

+(void)updateName:(NSString *)newName andPrice:(float)price  withId:(int)bookId;//更新
+(void)updateName:(NSString *)newName andPrice:(float)price andImage:(UIImage *)newImage withId:(int)bookId;//更新包括图片的全记录内容


@end
