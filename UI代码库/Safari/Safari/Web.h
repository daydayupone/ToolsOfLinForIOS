//
//  Web.h
//  Safari
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Web : NSObject

@property (assign,nonatomic) int *webid;
@property (retain,nonatomic) NSString *weburl;
@property (retain,nonatomic) NSString *webname;
@property (retain,nonatomic) NSData *webimage;

+(NSMutableArray *)findAll;
//存储网页数据
//+ (void) insertId:(int) webId andUrl:(NSString *)webUrl andName:(NSString *)webName andImage:(NSData *) webImage;
+ (void) andUrl:(NSString *)webUrl andName:(NSString *)webName andImage:(NSData *) webImage;
@end
