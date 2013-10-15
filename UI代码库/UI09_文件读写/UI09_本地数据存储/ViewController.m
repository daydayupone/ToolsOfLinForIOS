//
//  ViewController.m
//  UI09_本地数据存储
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)save{
    NSLog(@"进入后台");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     --------文件读写是最简单的数据持久化方式
     通常使用writeToFile:方法实现文件的写操作
     部分类提供了读文件的方法
     */
    
    
	// 注册通知,使用HOME键进入后台是调用通知的方法 saved
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saved) name:UIApplicationDidEnterBackgroundNotification/*使用HOME键进入后台是调用通知的方法 saved */ object:nil];
    
   
    
    //---------------读取文件
    
    NSString *filePath = [self getPath:@"abc.txt"];
    //重新读取存储好的文件的，存储数组
    NSArray *initArray = [[NSArray alloc]initWithContentsOfFile:filePath];
    //根据下标获得数据内容
    self.txt1.text = [initArray objectAtIndex:0];
    self.txt2.text = [initArray objectAtIndex:1];
    self.txt3.text = [initArray objectAtIndex:2];
    
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

//存储数据的方法
- (void)saved{
    
    //要存储的数据存储进数组之中
    NSArray *array = [NSArray arrayWithObjects:self.txt1.text,self.txt2.text,self.txt3.text, nil];
    
    //调用 拼接存储文件路径 的方法 
    NSString *filePath = [self getPath:@"abc.txt"];
    NSLog(@"文件路径为：%@",filePath);
    
    //写入数据的方法
    [array writeToFile:filePath atomically:YES];
}

/*
- (void)writeFile:(NSString *)file
{
    //创建文件管理器
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    //1、参数NSDocumentDirectory要获取的那种路径
//    NSArray*  paths = NSSearchPathForDirectoriesInDomains{NSDocumentDirectory,NSUserDomainMask,YES);
    //2、得到相应的Documents的路径
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    //3、更改到待操作的目录下
//    [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
    //4、创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    //[fileManager removeItemAtPath:@“username” error:nil];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"username"];
    //5、创建数据缓冲区
    NSMutableData  *writer = [[NSMutableData alloc] init];
    //6、将字符串添加到缓冲中
    [writer appendData:[file dataUsingEncoding:NSUTF8StringEncoding]];
    //7、将其他数据添加到缓冲中
    NSLog(@"存储路径：%@",path);
    //将缓冲的数据写入到文件中
    [writer writeToFile:path atomically:YES];//yes后可以保证写入有用的数据
    [writer release];
}
*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_txt1 release];
    [_txt2 release];
    [_txt3 release];
    [super dealloc];
}
@end
