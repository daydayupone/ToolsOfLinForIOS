//
//  ViewController.m
//  UINavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

//通过代理实现视图控制器的切换



#import "ViewController.h"
#import "SecondViewController.h"
#import "SingalTon.h"//导入单例类

@interface ViewController ()

@end

@implementation ViewController

//实现代理方法
- (void)setBtnTitle:(NSString *)title whitTag:(int)tag
{
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:tag];//通过标记获得对应的button对象
    [btn1 setTitle:title forState:UIControlStateNormal];//使用参数更改button的标题
    
}



//创建一组方法，可以接收形参用于创建Button
//它的内存管理是自动的，不需要手动管理内存
//int i = 1;
- (UIButton *)myCreatButtonType:(UIButtonType)type andFrame:(CGRect)frame andTitle:(NSString *)title andBackgroundImage:(UIImage *)img andAction:(SEL)action andTag:(int)aTag//参数1：按键类型、按键位置长宽、按键的名字、按键的背景图片、按键的调用的方法
{
    UIButton *btn1 = [UIButton buttonWithType:type];//UIButtonTypeCustom为自定义的Button
    btn1.frame = frame;
    [btn1 setTitle:title forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];//设置标题颜色
    [btn1 setBackgroundImage:img forState:UIControlStateNormal];
    
   // btn1.tag = 100+i++;//做标记
    btn1.tag = aTag;//做标记
    [btn1 addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];//设定Button的单击事件
    [self.view addSubview:btn1];
    return btn1;//返回
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);
    SingalTon *ton = [SingalTon getInstance];
    self.title = (ton.wenBen== nil)? @"书房":ton.wenBen;//对进行判断
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"klll");
    NSString *str = @"122222";
    NSString *str2 = @"134567";
    NSString *str3 = @"345677";
    NSArray *sore = [[NSArray alloc]initWithObjects:str,str2,str3, nil];
    NSArray *sore2 = [sore sortedArrayUsingSelector:@selector(compare:) ];
    NSLog(@"排序结果%@",sore2);
    
	// Do any additional setup after loading the view, typically from a nib.
    //实例化一个单例对象
    SingalTon *sing = [SingalTon getInstance];
    self.title = (sing.wenBen == nil) ? @"书房":sing.wenBen  ;
    //设置导航控制栏的标题
    //self.title = @"书房";
    
    //设置背景图片
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-20-44)];//高是-20状态栏，-44的导航栏
    UIImage *img = [UIImage imageNamed:@"shufang.png"];
    bgView.image = img;
    [self.view addSubview:bgView];
    
   // for (int i =0; i<3; i++) {
        //设置Button
    int i = 0;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];//UIButtonTypeCustom为自定义的Button
        btn1.frame = CGRectMake(5+100*i, 20, 90, 60);
        [btn1 setTitle:@"三字经" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];//设置标题颜色
        [btn1 setBackgroundImage:[UIImage imageNamed:@"szj.png"] forState:UIControlStateNormal];
        btn1.tag = 100;//标记
        [btn1 addTarget:self action:@selector(pushNext:) forControlEvents:UIControlEventTouchUpInside];//设定Button的单击事件
        [self.view addSubview:btn1];
        
        //下面尝试直接调用方法来创建Button！！
        UIImage *img1 = [UIImage imageNamed:@"beixing.png"];
        [self myCreatButtonType:UIButtonTypeCustom andFrame:CGRectMake(5+100*i, 95, 90, 60) andTitle:@"背影" andBackgroundImage:img1 andAction:@selector(pushNext:) andTag:101];
        
        UIImage *img2 = [UIImage imageNamed:@"yecao.png"];
        [self myCreatButtonType:UIButtonTypeCustom andFrame:CGRectMake(5+100*i, 170, 90, 60) andTitle:@"野草" andBackgroundImage:img2 andAction:@selector(pushNext:) andTag:102];
   // }
    
    
    
    
    
    
}

//推送到下一个页面方法
- (void)pushNext:(id)sender
{
    //————————————使用属性进行控制视图信息的传递
    
    SecondViewController *secView = [[SecondViewController alloc]init] ;//实例化一个视图的对象，持有 SecondViewController 的对象 secView
    
    //属性传参
    secView.title = [sender currentTitle];//获得最新的标题
    
    [self.navigationController pushViewController:secView animated:YES];//开始视图控制器之间的切换,显示下一个视图
    
    secView.imgV/*此处的 imgV 是 SecondViewController 类之中声明了的属性*/.image = [sender currentBackgroundImage];//改变视图的背景颜色//注意代码的执行顺序，要在SecondViewController视图被切换出来后才能调用
    
   // secView.textField.text = [sender currentTitle];//currentTitle是获得点击的Button的Title
    
    secView.textField.placeholder =  [sender currentTitle];
    
    secView.btnTag = [sender tag];//获得被调用的button的标记
    secView.delegate = self;//指定 SecondViewController 的代理 为目前的类 ViewController
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

@end
