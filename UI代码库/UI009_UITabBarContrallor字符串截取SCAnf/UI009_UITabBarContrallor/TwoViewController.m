//
//  TwoViewController.m
//  UI009_UITabBarContrallor
//
//  Created by ibokan on 13-5-27.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "TwoViewController.h"
#import <QuartzCore/QuartzCore.h>//导入绘图框架


@interface TwoViewController ()

@end

@implementation TwoViewController

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
    self.view.backgroundColor = [UIColor magentaColor];
    
    //--------------------------UITextView的使用
    //初始化
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    //加入视图
    [self.view addSubview:_textView];
    //定制UITextView的边角为20的圆角 注意：要添加导入QuartzCore框架
    _textView.layer.cornerRadius = 20;
    
        
    //------------------------工具条Toolbar的使用
    
    //初始化

    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 33)];
    //使toolBar跟着弹出的键盘移动
    _textView.inputAccessoryView = toolBar;
    //设置toolBar的外观：黑色透明
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    
    //------------------------为在toolBar添加按钮做一些准备
        //创建UIBarButtonItem
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"hell" style:UIBarButtonItemStyleDone target:self action:nil];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(hui)];//点击该按钮时，键盘弹回
    
    //为了按钮的美观，创建空的按钮
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //将UIBarButtonu放进数组，并赋值给toolBar的items
    //成功的添加了按钮了
    toolBar.items = [NSArray arrayWithObjects:left,space,space,right, nil];
    
    
    
    
}


//调用的方法
- (void)hui
{
    [self.textView resignFirstResponder];//要导入<UIKeyInput>协议才能调用的方法
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
