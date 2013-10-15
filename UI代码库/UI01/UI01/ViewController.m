//
//  ViewController.m
//  UI01
//
//  Created by ibokan on 13-5-8.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//text在回车后，隐藏键盘
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//取消第一响应
    return YES;
}

//自定义的判断整数的函数
- (BOOL) isPureInt:(NSString *)string
{
    NSScanner *scan = [[NSScanner alloc] initWithString:string];
    int val;
    return [scan scanInt:&val]&&[scan isAtEnd];
}

//在结束数字输入之后，判断结果是不是整数型的
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    NSString *tmp = textField.text;
    BOOL flag = [self isPureInt:tmp];//此处调用了自定义的isPurInter：方法
    if (flag) {
        NSLog(@"文本框内是整数");
    }else{
        NSLog(@"文本框内不是整数");
    }
    return YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //实例化Label、Text
    self.text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,150, 50, 30)];
    self.text1.delegate = self;//将自身作为执行协议的代理
    
    _text1.backgroundColor = [UIColor whiteColor];
    _text1.borderStyle = UITextBorderStyleRoundedRect;
    _text1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//默认的键盘类型为输入数字类型的
    _text1.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;//使文字效果居中
    _text1.placeholder = @"请输入";//设置text中未输入数字时候的提示文字
    [self.view addSubview:_text1];
        
    self.text2 = [[UITextField alloc] initWithFrame:CGRectMake(70, 150, 50, 30)];
    self.text2.delegate = self;//将自身作为执行协议的代理
    _text2.backgroundColor = [UIColor whiteColor];
    _text2.borderStyle = UITextBorderStyleRoundedRect;
    _text2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//默认的键盘类型为输入数字类型的
    _text2.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;//使文字效果居中
    _text2.placeholder = @"请输入";//设置text中未输入数字时候的提示文字
    
    [self.view addSubview:_text2];
    
    //label
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 150, 10, 30)];
    _label1.backgroundColor = [UIColor grayColor];
    _label1.textAlignment = UITextAlignmentCenter;
    _label1.text = @"+";
    [self.view addSubview:_label1];
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 150, 10, 30)];
    _label2.backgroundColor = [UIColor grayColor];
    _label2.textAlignment = UITextAlignmentCenter;
    _label2.text = @"=";
    [self.view addSubview:_label2];
    
    self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(132, 150, 50, 30)];
    _label3.backgroundColor = [UIColor blackColor];
    _label3.textAlignment = UITextAlignmentCenter;
    _label3.textColor = [UIColor whiteColor];//设置字体颜色
    [self.view addSubview:_label3];
    
    //创建button（用于加减计算）
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];//设置button的类型
    button1.frame = CGRectMake(220, 150, 50, 30);
    [button1 setTitle:@"运算" forState:UIControlStateNormal];//设置button的标题
    [button1 addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];//确定触发自定义方法的方式
    [self.view addSubview:button1];
}

- (void) add
{
    int sum = [self.text1.text intValue ] + [self.text2.text intValue];
    
    self.label3.text = [NSString stringWithFormat:@"%d",sum];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
