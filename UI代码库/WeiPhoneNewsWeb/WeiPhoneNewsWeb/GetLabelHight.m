//
//  GetLabelHight.m
//  WeiPhoneNews_Lin
//
//  Created by ibokan on 13-6-16.
//  Copyright (c) 2013年 林建裕. All rights reserved.
//

#import "GetLabelHight.h"

@implementation GetLabelHight

- (CGFloat) highOfLabel:(UILabel *) label numberTextOfLabel:(NSString *) text andFontSize:(CGFloat) fontSize
{
    
    //无行数限制
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    //设置字体
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    //设置一个行高上限
    // 250是定制宽度，3000决定了可显示的字符串数量
    CGSize limtSize = CGSizeMake(250,4000);
    //得到文字内容
    NSString *labelText = text;
                    
    //根据之前的字体、行宽高、文字计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [labelText sizeWithFont:font constrainedToSize:limtSize lineBreakMode:NSLineBreakByWordWrapping];
                    
    //得到高度
    CGFloat high = labelsize.height;
    //返回高度
    return high;
    
}


@end
