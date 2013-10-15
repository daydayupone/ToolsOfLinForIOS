//
//  SecondeViewController.m
//  UIHome_NavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "SecondeViewController.h"
#import "ViewController.h"


@interface SecondeViewController ()

@end

@implementation SecondeViewController

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
	// Do any additional setup after loading the view.
    //设置当前导航页面的标题
    self.title = @"控制视图名称";
    
    //创建文本框
    self.myText = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 60,40)];
    self.myText.backgroundColor = [UIColor whiteColor];
    self.myText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.myText];
    
    //创建按钮
    UIButton *myButton = [UIButton buttonWithType:1];
    myButton.frame = CGRectMake(160, 100, 40, 40);
    [myButton setTitle:@"切换" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    
    
    
    
}

- (void)pop:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];//切换回根控制视图
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(changeTitle:)])//如果存在代理并且代理实现了协议的方法
    {
        [self.delegate changeTitle:self.myText.text];//触发该方法时，SecondeViewController的代理执行changeTitle:，将myText之中的值作为参数
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
