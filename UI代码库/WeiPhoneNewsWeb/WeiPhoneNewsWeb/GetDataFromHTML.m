//
//  GetDataFromHTML.m
//  WeiPhoneNews_Lin
//
//  Created by ibokan on 13-6-15.
//  Copyright (c) 2013年 林建裕. All rights reserved.
//

#import "GetDataFromHTML.h"
#import "TFHpple.h"

@implementation GetDataFromHTML

- (NSString *) startAnalysisTF:(TFHpple *) weiTf andXpath:(NSString *) aXpath
{
    //获得网页上解析的数据
    NSArray *  commentArray = [weiTf searchWithXPathQuery:aXpath];
    
    NSString * commentStr = [[[NSString alloc]init]autorelease];
    
    //遍历出数组内容
    for(int i=0;i<[commentArray count];i++)
    {
    TFHppleElement *element = [commentArray objectAtIndex:i];
    //获得
    commentStr = [element content];
    }
    
    NSLog(@"commentStr得到的字符串：%@",commentStr);
    
    return commentStr;
}



@end
