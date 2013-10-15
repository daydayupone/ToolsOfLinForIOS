//
//  ViewController.m
//  UI_ASIHTTPREquest
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"//导入网络连接第三方类

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//异步连接请求
- (IBAction)aLoadHttp:(id)sender {
    //获取一个url路径
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.gif"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;//异步代理
    [request startAsynchronous];//异步请求
}
//异步请求的代理方法
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //异常信息
    NSError *error = [request error];
    //判断释放异常
    if (error) {
        NSLog(@"错误信息是：%@",error);
    }
    else{
        //将获取的网络数据封装成data类型的数据[request responseData]
        
        self.myImage.image = [UIImage imageWithData:[request responseData]];
    }
}

//同步强求
- (IBAction)loadHttp:(id)sender {
    //获取一个url路径
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.gif"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];//同步请求
    
    //异常信息
    NSError *error = [request error];
    //判断释放异常
    if (error) {
        NSLog(@"错误信息是：%@",error);
    }
    else{
        //将获取的网络数据封装成data类型的数据[request responseData]
        
        self.mySecond.image = [UIImage imageWithData:[request responseData]];
    }
    
}



- (void)dealloc {
    [_myImage release];
    [_mySecond release];
    [super dealloc];
}
@end
