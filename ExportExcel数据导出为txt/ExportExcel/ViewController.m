//
//  ViewController.m
//  ExportExcel
//
//  Created by jiawei on 13-12-28.
//  Copyright (c) 2013年 GitomLJYU. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
static CHCSVWriter *sharedWriter = nil;
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSLog(@"temp path == %@",NSTemporaryDirectory());
    NSString *pathstring = [[NSBundle mainBundle] pathForResource:@"Members58200" ofType:@"plist"];
    NSArray *resultArray = [NSArray arrayWithContentsOfFile:pathstring];
    NSLog(@"memberArray ar == %@",resultArray);
    
    [resultArray enumerateObjectsUsingBlock:^(id str,NSUInteger index, BOOL* te){
       
        NSDictionary *memberDic = [resultArray objectAtIndex:index];
        NSString *realName = [memberDic objectForKey:@"realname"];
        NSString *dateStr = [memberDic objectForKey:@"createDate"];
        NSLog(@"membedic = %@,%@,%d",realName,dateStr,index);
        
    }];
    
    CHCSVWriter *csvWriter = [ViewController sharedWriter];
    [csvWriter writeField:@"日期             "];
    [csvWriter writeField:@"病区             "];
    [csvWriter writeField:@"姓名             "];
    [csvWriter writeLine];

    [resultArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //病人列表
        NSDictionary *dictionary = [resultArray objectAtIndex:idx];
        NSString *PatientName = [dictionary objectForKey:@"realname"];
        NSString *Office = [dictionary objectForKey:@"telephone"];
        NSString *Date = [dictionary objectForKey:@"createDate"];
        [csvWriter writeField:Date];
        [csvWriter writeField:Office];
        [csvWriter writeField:PatientName];
        
        [csvWriter writeLine];
    }];
    [csvWriter closeFile];
    
    sharedWriter = nil;
    
    
}

+ (CHCSVWriter *)sharedWriter{
    @synchronized (self) {
        if (sharedWriter == nil) {
            sharedWriter = [[CHCSVWriter alloc] initWithCSVFile:[DOCUMENT stringByAppendingPathComponent:@"所有记录.txt"] atomic:NO];
        }
        return sharedWriter;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
