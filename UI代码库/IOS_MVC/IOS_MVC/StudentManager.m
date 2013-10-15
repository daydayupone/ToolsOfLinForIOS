//
//  StudentManager.m
//  IOS_MVC
//
//  Created by ibokan on 13-6-21.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import "StudentManager.h"
#import "Student.h"

@implementation StudentManager

- (NSArray *)getAllStudent
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i= 0; i<100; i++) {
        NSString *nm = [NSString stringWithFormat:@"xid%d",i];
        NSString *ag = [NSString stringWithFormat:@"%d",i];
        Student *st = [[Student alloc]init];
        st.name = nm;
        st.age = ag;
        [arr addObject:st];
    }
    return arr;
}

@end
