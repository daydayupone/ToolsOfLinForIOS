//
//  ViewController.m
//  Safari
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "ViewController.h"
#import "SaveViewController.h"
#import "FevoreViewController.h"
#import "TableViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.myWeb.delegate = self;//设置代理方法
    
    [self.view addSubview:self.activit];
    NSString *theTitle=[self.myWeb stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = theTitle;
//    //连接网络的方法
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    [self.myWeb loadRequest:req];
    
    
    
}

- (IBAction)goback:(id)sender {
    [self.myWeb goBack];
}

- (IBAction)goforward:(id)sender {
    [self.myWeb goForward];
}


- (IBAction)searchURL:(id)sender {
    //连接网络的方法
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.search.text]];
                  
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.myWeb loadRequest:req];
    
    //收起键盘
    [self.search resignFirstResponder];
    
}

//开始连接数据
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //菊花闪动
    [self.activit startAnimating];
    NSString *currurl = self.myWeb.request.URL.absoluteString;
    
    NSLog(@"%@",currurl);
}

//接收连接
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //菊花停止
    [self.activit startAnimating];
    self.title = [self.myWeb stringByEvaluatingJavaScriptFromString:@"document.title"];
}

//连接失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"连接失败");
}

//读取保存的网站
- (IBAction)loadUrl:(id)sender {
    
    FevoreViewController *fevore = [[FevoreViewController alloc]init];
    [self.navigationController pushViewController:fevore animated:YES];
    
}

//存储网址
- (IBAction)saveUrl:(id)sender {
    
    SaveViewController *save = [[SaveViewController alloc]init];
    
     //推送下页
    [self.navigationController pushViewController:save animated:YES ];
    
    
    //获得当前网页名称
    NSString *theTitle=[self.myWeb stringByEvaluatingJavaScriptFromString:@"document.title"]; 
    save.name.text = theTitle;
    //获得当前网页的图标
    NSURL *url = [[NSURL alloc] initWithScheme:[self.myWeb.request.URL scheme] host:[self.myWeb.request.URL host] path:@"/favicon.ico"];
    NSData *data =[NSData dataWithContentsOfURL:url];
    save.logo.image = [UIImage imageWithData:data];
    NSLog(@"%@",save.url.text);
    
    //获得当前网页网址
    NSString *currurl = self.myWeb.request.URL.absoluteString;
    save.url.text = currurl;
   
    //[save release];
}

//查看收藏夹
- (IBAction)findSaved:(id)sender {
    TableViewController *table = [[TableViewController alloc]init];
    
    [self.navigationController pushViewController:table animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myWeb release];
    [_search release];
    [_go release];
    [_activit release];
    [super dealloc];
}
@end
