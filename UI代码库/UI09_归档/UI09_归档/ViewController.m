//
//  ViewController.m
//  UI09_归档
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //创建要归档的Person类型对象p1
    Person *p1 = [[Person alloc]init];
    //给p1对象赋值
    p1.age = [NSNumber numberWithInt:20];
    p1.name = @"ss";
    p1.phone = @"1234";
    
    //创建用于存储归档内容的二进制数据对象
    NSMutableData *md = [[NSMutableData alloc]init];
    
    //创建归档对象 指定归档内容存入md对象
    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:md];
    
    //完成归档，将数据存储进person1 文本之中
    [arch encodeObject:p1 forKey:@"person1"];
    
    //编码结束
    [arch finishEncoding];
    
    //调用获得路径，并且进行存储路径拼接的方法
    NSString *path = [self getPath:@"person.txt"];
    
    NSLog(@"%@",path);//打印文件路径
    
    //将文件写入文件之中
    [md writeToFile:path atomically:YES];
    
    
    //-------------------反归档
    
    // 注册通知,使用HOME键进入后台是调用通知的方法 saved
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fangGuiDan) name:UIApplicationDidEnterBackgroundNotification/*使用HOME键进入后台是调用通知的方法 saved */ object:nil];
    
}


- (void)fangGuiDan
{
    //获取文件存储路径
    NSString *path = [self getPath:@"person.txt"];
    //将文件路径里的文件读取出来，存储为二进制类型的数据
    NSData *read = [[NSData alloc]initWithContentsOfFile:path];
    //反归档，将上一步的二进制数据进行反归档
    NSKeyedUnarchiver *key = [[NSKeyedUnarchiver alloc]initForReadingWithData:read];
    //取得二进制数据里面的 person1 的数据
    Person *p = [key decodeObjectForKey:@"person1"];
    //结束编码
    [key finishDecoding];
    NSLog(@"name = %@,phone = %@,age = %@",p.name,p.phone,p.age);
    
}

//获得路径，创建存储的文件夹
- (NSString *)getPath:(NSString *)filename
{
    //得到相应的Documents的路径
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    //拼接数据
    NSString *path = [documentDirectory stringByAppendingPathComponent:filename];
    //返回存储的路径
    return path;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
