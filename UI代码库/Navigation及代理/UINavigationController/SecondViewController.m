//
//  SecondViewController.m
//  UINavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "SecondViewController.h"

#import "ViewController.h"

#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


//执行代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    
    [textField resignFirstResponder];//取消第一响应
    
    return YES;
}
//在用键盘输入内容时候，输入框上移
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:1 animations:^{
        //只让一些固定的视图组件位移
//        self.textField.frame = CGRectMake(30, 300-180,80, 40) ;//文本框上移动的200像素
//        self.button.frame = CGRectMake(110, 300-180, 40, 40) ;
        
        //视图上移
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y-200);
    }];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:1 animations:^{
        //[textField resignFirstResponder];//取消第一响应
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y+200);
    }];
    return YES;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//视图控制器显示界面内容的时候
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 180, 200)];
    
    [self.view addSubview:self.imgV];
    
    //创建TEXTFile
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(30, 300,80, 40)];
    self.textField.delegate = self;//将自身设为代理
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//设置textFile文字设置文字垂直对齐
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    //创建Button
    self.button = [UIButton buttonWithType:1];
    self.button.frame = CGRectMake(110, 300, 40, 40);
    [self.button setTitle:@"改变" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(change ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    //创建Button1
    self.button1 = [UIButton buttonWithType:1];
    self.button1.frame = CGRectMake(110, 200, 40, 40);
    [self.button1 setTitle:@"下一个界面" forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(change3 ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    
}

- (void)change
{
    
    //使用popTo切换视图控制器
    [self.navigationController popToRootViewControllerAnimated:YES];//使当前的视图控制器出栈，显示还在栈中并且处于栈上层的视图控制器ViewController
    
    //令代理执行协议内的方法
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(setBtnTitle:whitTag:)]) {//如果代理对象存在，并且实现了代理方法- (void)setBtnTitle:whitTag:
        [self.delegate setBtnTitle:self.textField.text whitTag:self.btnTag];
        
    }
}

- (void)change3
{
    ThirdViewController *third = [[ThirdViewController alloc]init];
    //使界面3入栈
    [self.navigationController pushViewController:third animated:YES];//将界面ThirdViewController压入栈
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
