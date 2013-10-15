//
//  ViewController.m
//  UIGCD_
//
//  Created by ibokan on 13-7-2.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import "ViewController.h"
#import "GCDViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)down:(id)sender
{
    //注意图片出现的先后顺序根据下载数据的大小而定，不分线程先后顺序。
    
    if ([sender isEqualToString:@"1"]) {
        NSURL *url = [NSURL URLWithString:@"http://www.xmrc.com.cn/xmrc/xiamen/Economy/201101/W020110118537816878772.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.img1.image = [UIImage imageWithData:data];
    }
    
    if ([sender isEqualToString:@"2"]) {
        NSURL *url = [NSURL URLWithString:@"http://www.xmrc.com.cn/xmrc/xiamen/Place/Gulangyu/200903/W020090314583995113026.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.img2.image = [UIImage imageWithData:data];
    }
    
    if ([sender isEqualToString:@"3"]) {
        NSURL *url = [NSURL URLWithString:@"http://www.xmrc.com.cn/xmrc/xiamen/Place/Gulangyu/200903/W020090315469662301476.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.img3.image = [UIImage imageWithData:data];
        
    }
    
    if ([sender isEqualToString:@"4"]) {
        NSURL *url = [NSURL URLWithString:@"http://www.xmrc.com.cn/xmrc/xiamen/Place/Huandaolu/200903/W020090315414662144989.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.img4.image = [UIImage imageWithData:data];
        
    }
    
}


- (IBAction)testGCD:(id)sender {
    
    NSLog(@"多线程");
    //创建线程操作对象
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(down:) object:@"1"];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(down:) object:@"2"];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(down:) object:@"3"];
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(down:) object:@"4"];
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //将操作对象加入队列
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"关于NSOperation";
    
	UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"GCD" style:UIBarButtonItemStyleDone target:self action:@selector(gcd)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
}

- (void)gcd
{
    GCDViewController *gcd = [[GCDViewController alloc]init];
    [self.navigationController pushViewController:gcd animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
