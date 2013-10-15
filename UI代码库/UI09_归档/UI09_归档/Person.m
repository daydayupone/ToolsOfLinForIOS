//
//  Person.m
//  UI09_归档
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize age,name,phone;

//编码方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //设定键值，将数据存储进字典之中
    [aCoder encodeObject:self.age forKey:@"page"];
    [aCoder encodeObject:self.name forKey:@"pname"];
    [aCoder encodeObject:self.phone forKey:@"pphone"];
    
}

//解码方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    //通过键值读取（解码）数据
    self.age = [aDecoder decodeObjectForKey:@"page"];
    self.name = [aDecoder decodeObjectForKey:@"pname"];
    self.phone = [aDecoder decodeObjectForKey:@"pphone"];
    
    return self;//返回查询结果
}







@end
