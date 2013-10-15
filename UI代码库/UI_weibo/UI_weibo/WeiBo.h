//
//  WeiBo.h
//  UI_weibo
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiBo : NSObject

//该类的属性是为 单元格 提供内容的

//头像、回复头像
@property (retain,nonatomic) UIImage *head,*responsePic;

//作者信息
@property (retain,nonatomic) NSString *authorLable,*title,*responseTitle;


//提供便利构造方法
+(id)weiboCreate:(NSString *) anAuthor andTitle:(NSString *)tl andResponseTitle:(NSString *) rt andHead:(UIImage *) h andPic:(UIImage *)p;

@end
