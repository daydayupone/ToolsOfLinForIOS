//
//  SearchViewController.m
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
- (IBAction)btnPress:(id)sender {
    [self.textField resignFirstResponder];
    NSURL *url=[NSURL URLWithString:self.textField.text];
    //异步请求下载
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:req delegate:self];
}

//----------------------异步需要 自己代理  并且继承了四个方法----------------------------
//连接建立成功
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"连接建立成功开始");
    //创建接收数据的二进制finalData对象
    self.finalData=[[NSMutableData alloc]init];
}
//连接接受数据 可能执行很多次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"连接正在接受图片数据 大小：%d",[data length]);
    [self.finalData appendData:data];
    NSLog(@"连接已经接受图片数据 大小：%d",[self.finalData length]);
}
//图片的处理
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"连接下载完成");
    //4处理NSMutableData  将二进制转换为图片
    UIImage *img1=[UIImage imageWithData:self.finalData];
    //图形视图初始化图片指定位img ------图像框
//    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,200)];
//    imgView1.image=img1;
    
    //将图形视图添加到默认视图
//    [self.view addSubview:imgView1];
    self.imageView.image=img1;
}









- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     NSLog(@"search viewDidLoad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textField release];
    [_imageView release];
    [super dealloc];
}
@end
