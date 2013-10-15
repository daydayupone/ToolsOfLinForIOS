//
//  SecondViewController.m
//  ui002
//
//  Created by 颜振洋 on 13-5-8.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "SecondViewController.h"
#import "FourViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad//下载完后
{
    [super viewDidLoad];
    //self.view.userInteractionEnabled=NO;//当父视图关闭用户交互，那么其子视图也就关闭了
    UIButton*btn=[UIButton buttonWithType:1];
    btn.frame=CGRectMake(100, 300, 100, 50);
    [self.view addSubview:btn];
//    btn.userInteractionEnabled=NO;//设置按钮不支持点击事件交互，按钮不能点击
    
    self.view.backgroundColor=[UIColor yellowColor];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    lab.text=@"hello";
    [self.view addSubview:lab];
    
    [UIView beginAnimations:nil context:nil];//开启动画
    [UIView setAnimationDuration:4];//动画时长
    lab.alpha=0.5;//设置透明度 取值范围0-1
    lab.center=CGPointMake(lab.center.x, lab.center.y+100);//向下移动，改变中心点的位置
    [UIView commitAnimations];//动画提交，开始执行动画
    
    UIButton *changeButton = [UIButton buttonWithType:1];
    changeButton.frame = CGRectMake(160, 240, 80, 50);
    [changeButton setTitle:@"切换View" forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
	// Do any additional setup after loading the view.
}

- (void)changeView:(id)sender
{
    FourViewController *four = [[FourViewController alloc]init];
    [self.navigationController pushViewController:four animated:YES];
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
