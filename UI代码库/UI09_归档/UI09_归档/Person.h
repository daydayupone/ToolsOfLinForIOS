//
//  Person.h
//  UI09_归档
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <Foundation/Foundation.h>

//数据持久化 NSCoding
@interface Person : NSObject<NSCoding>//导入此类实现数据的归档、反归档

@property (nonatomic,retain) NSNumber *age;//将原始的int、float变化为对象类型的数据NSNumber
@property (nonatomic,retain) NSString *name,*phone;



@end
