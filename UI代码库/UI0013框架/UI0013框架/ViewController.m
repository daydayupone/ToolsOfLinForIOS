//
//  ViewController.m
//  UI0013框架
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 Miguel. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"

@interface ViewController ()

@end

@implementation ViewController

//测试同步下载
-(void)testASIHttpRequest{
    NSURL *url=[NSURL URLWithString:@"http://f.hiphotos.baidu.com/album/w%3D2048%3Bq%3D75/sign=476f84a6562c11dfded1b823571f59a1/9825bc315c6034a87b69fbc4ca134954082376ef.jpg"];
    ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
    req.delegate=self;
    //测试同步请求
    [req startSynchronous];
    NSError *error=[req error];
    
    if (!error) {
        NSString *response=[req responseString];
        NSLog(@"response=%@",response);
        UIImage *img=[UIImage imageWithData:[req responseData]];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        imgView.image=img;
        [self.view addSubview:imgView];
    }
    else{
        NSLog(@"error=%@",error);
    }
}
//测试异步下载
-(void)testASIHttpRequest2{
    NSURL *url=[NSURL URLWithString:@"http://f.hiphotos.baidu.com/album/w%3D2048%3Bq%3D75/sign=476f84a6562c11dfded1b823571f59a1/9825bc315c6034a87b69fbc4ca134954082376ef.jpg"];
    ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
    req.delegate=self;
    [req startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest*)request{
    
    NSError *error=[request error];
    if (!error) {
        NSString *response=[request responseString];
        NSLog(@"response=%@",response);
        UIImage *img=[UIImage imageWithData:[request responseData]];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        imgView.image=img;
        [self.view addSubview:imgView];
    }
    else{
        NSLog(@"error=%@",error);
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self testASIHttpRequest];//测试同步
//    [self testASIHttpRequest2];//测试异步
	// Do any additional setup after loading the view, typically from a nib.
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
