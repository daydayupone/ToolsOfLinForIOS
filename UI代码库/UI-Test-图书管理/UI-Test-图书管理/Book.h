//
//  Book.h
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property(assign,nonatomic)int bookId;
@property(retain,nonatomic)NSString *bookName,*bookPublisher,*bookPublishDate,*bookAuthor,*bookIntro;
@property(retain,nonatomic)UIImage *bookFaceImage;


+(NSMutableArray*)findAll;
+(void)insertWithName:(NSString *)name andPublisher:(NSString *)publisher andDate:(NSString *)publisherDate andAuthor:(NSString *)author andfaceImage:(UIImage *)faceImage andIntro:(NSString *)intro;
+(void)deleteWithId:(int)bookId;

//收藏夹的方法
+(void)putIntoFavoriteWithBook:(Book *)book;
+(NSMutableArray*)findAllFavorite;
+(void)deleteFavoriteWithId:(int)bookId;
@end
