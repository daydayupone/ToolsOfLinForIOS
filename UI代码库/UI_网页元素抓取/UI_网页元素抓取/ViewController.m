//
//  ViewController.m
//  UI_网页元素抓取
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"//xpath

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSURL *url = [NSURL URLWithString:@"http://www.weiphone.com/"];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
    req.delegate = self;
    [req startAsynchronous];//异步协议
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSError *error = [request error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    else{
        NSString *respStr = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
        NSLog(@"返回：%@",respStr);
        
        //创建基于xpath解析thml类的对象
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:[request responseData]];
        
        NSArray *ary = [xpathParser searchWithXPathQuery:@"/html[contains(concat(' ', @class, ' '), ' yui3-js-enabled ')]/body[contains(concat(' ', @class, ' '), '  ')]/div[contains(concat(' ', @class, ' '), ' column3 ')]/div/div/div[contains(concat(' ', @class, ' '), ' left_2c ')]/div[contains(concat(' ', @class, ' '), ' column3_sub_left ')]/div[@id='top_a_week']/div/ul/li[2]/a/span "];//li代表的是列表项，[1]表示取第几个列表，为了遍历出每一个列表，可以考虑将[1]去除
        
        NSLog(@"++++++%@",ary);
        
        
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
