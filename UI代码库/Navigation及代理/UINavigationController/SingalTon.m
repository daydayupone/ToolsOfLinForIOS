//
//  SingalTon.m
//  UINavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "SingalTon.h"



@implementation SingalTon

@synthesize wenBen;
//创建单例
static SingalTon *instanc = nil;

+ (SingalTon *) getInstance
{
    if (instanc == nil) {
        instanc = [[SingalTon alloc]init];
    }
    return instanc;
}





@end
