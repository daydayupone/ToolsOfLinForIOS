//
//  JietuViewController.m
//  ui003
//
//  Created by 颜振洋 on 13-5-10.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "JietuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Jietu.h"
@interface JietuViewController ()

@end

@implementation JietuViewController

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
    //2、touch处理触摸3、根据起始点和终点画虚线矩形4、将矩形用接图方法接图5、移动矩形（戴动画）
    Jietu*jt=[[Jietu alloc]initWithFrame:self.view.frame];//创建一个Jietu*dv跟系统默认创建的UIview一样大
    [self.view addSubview:jt];//将Jietu*jt添加到view上
//----------------------------1、给view设置图片背景--------------------------
    [jt setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tu.jpg"]]];//将图片设置为Jietu*jt的背景颜色

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
