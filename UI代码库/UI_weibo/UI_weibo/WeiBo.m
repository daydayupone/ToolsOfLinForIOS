//
//  WeiBo.m
//  UI_weibo
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "WeiBo.h"

@implementation WeiBo
//提供便利构造方法
+(id)weiboCreate:(NSString *) anAuthor andTitle:(NSString *)tl andResponseTitle:(NSString *) rt andHead:(UIImage *) h andPic:(UIImage *)p{
    
    WeiBo *wei = [[WeiBo alloc]init];
    
    wei.title = tl;
    wei.head = h;
    wei.authorLable = anAuthor;
    wei.responseTitle = rt;
    wei.responsePic = p;
    
    return wei;
    
}
@end
