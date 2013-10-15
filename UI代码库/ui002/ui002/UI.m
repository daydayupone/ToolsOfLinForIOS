//
//  UI.m
//  ui002
//
//  Created by ibokan on 13-5-8.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "UI.h"

@implementation UI

- (void)viewDidLoad//下载完后
{
    [super viewDidLoad];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];//把他贴在窗口视图上
    view1.backgroundColor = [UIColor redColor];//设置视图的颜色
    view1.tag = 1001;//给view1对象赋值标签1001
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 280, 280)];//把他贴在view1上
    view2.backgroundColor = [UIColor blackColor];//颜色
    //让子视图随着父视图view1缩放宽高比例
    view2.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;//宽高同时随着变化
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 260, 260)];//把他贴在view1上
    view3.backgroundColor = [UIColor blueColor];
    //让子视图随着父视图view1缩放宽高比例
    view3.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:view1];
    [view1 addSubview:view2];
    [view1 addSubview:view3];
    
    //缩小按钮
    UIButton *button1 = [UIButton buttonWithType:3 ];
    button1.frame = CGRectMake(100, 350, 100, 50);
    [button1 setTitle:@"缩小" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(fangDa:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    //放大按钮
    UIButton *button2 = [UIButton buttonWithType:5];
    button2.frame = CGRectMake(100, 400, 100, 50);
    [button2 setTitle:@"放大" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(suoX) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

//修改view1的大小
- (void)fangDa:(id) sender
{
    //通过标签取得对象view1
    UIView *v1 = [self.view viewWithTag:1001];
    //先取得原始的对象的大小
    CGRect org = v1.frame;
    //通过对原始数值的更改实现缩小效果
    //坐标（）移动，
    v1.frame = CGRectMake(org.origin.x +10, org.origin.y +10, org.size.width -20,org.size.height -20);
}
//修改view1的大小

- (void)suoX
{
    //通过标签 tag 取得对象view1
    UIView *v1 = [self.view viewWithTag:1001];
    //先取得原始的对象的大小
    CGRect org = v1.frame;
    //通过对原始数值的更改实现缩小效果
    //坐标（x,y）移动，
    v1.frame = CGRectMake(org.origin.x -10, org.origin.y -10, org.size.width +20,org.size.height +20);
}





-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)didReceiveMemoryWarning//内存警告响应
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
