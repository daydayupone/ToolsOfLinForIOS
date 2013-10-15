//
//  ViewController.m
//  UIHome_NavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "ViewController.h"

#import "SecondeViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()
- (void) change;
@end

@implementation ViewController
@synthesize myText;//合成属性

- (void) changeName
{
    
}


//键盘收回的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];//取消第一反应
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //设置当前导航页面的标题
    self.title = @"控制视图名称";
    
    //创建文本框
    self.myText = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 60,40)];
    self.myText.backgroundColor = [UIColor whiteColor];
    self.myText.delegate = self;//自身作为代理执行键盘收回代理
    self.myText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.myText];
    
    //创建按钮
    UIButton *myButton = [UIButton buttonWithType:1];
    myButton.frame = CGRectMake(160, 100, 40, 40);
    [myButton setTitle:@"切换" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    
    
    //
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(doSomeThing)];
    
    self.navigationItem.leftBarButtonItem = bbi;
    
}

//切换方法
- (void) change:(id)sender
{
    //实例化要被切换出来的视图对象
    SecondeViewController *scv = [[SecondeViewController alloc]init];
    
    //调用该方法实现视图切换
    [self.navigationController pushViewController:scv animated:YES];
    
    //被切换出来的视图导航名变为textFiled输入的字符串
    scv.title = myText.text;
    
    scv.delegate = self;//
    
}

//实现代理方法
- (void)changeTitle:(NSString *)title
{
    self.title = title;
    
}

//UIBarButtonItem调用的方法
- (void)doSomeThing
{
    NSLog(@"UIBarButtonItem调用的方法");
    self.myText.text = @"UIBar调用的方法";
    
    ThirdViewController *third = [[ThirdViewController alloc]init];
    [self.navigationController pushViewController:third animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
