//
//  FourViewController.m
//  ui002
//
//  Created by ibokan on 13-5-8.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

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
    
    //创建多种颜色的数组,供遍历的时候使用
    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor yellowColor],[UIColor greenColor],[UIColor grayColor],[UIColor purpleColor],[UIColor whiteColor],[UIColor blackColor], nil];
    
    UIView *outView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 330)];
    outView.tag = 1000;//作为中间便利在changeColor中会用到
    outView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:outView];
    
    for (int i=1; i<7; i++) {//便利6次
        UIView *insiderView = [[UIView alloc]init];
        insiderView.tag = 1000+i;//定义对象的标记
        insiderView.backgroundColor = [colorArray objectAtIndex:i-1];//调用数组中的颜色。数组下标是0开始的，所以要减1
        insiderView.frame = CGRectInset(outView.frame, 20*i, 20*i);//这种函数用于创建一个大小不同，形状相同的图形
        [self.view addSubview:insiderView];
    }
    //使用定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeColor) userInfo:nil repeats:YES];//每隔一秒调用一次changeColor自定义方法，
}

- (void)changeColor
{
    NSLog(@"执行了");
    //获得标记的值
    UIView *v6 = [self.view viewWithTag:1006];//获得标记为1006的对象
    UIColor *c6 = v6.backgroundColor;
    
    for (int i =6; i>0; i --) {//交换view的颜色
        UIView *v0 = [self.view viewWithTag:1000+i];
        v0.backgroundColor = [self.view viewWithTag:1000+i-1].backgroundColor;
    }
    
    UIView *v1 = [self.view viewWithTag:1000];
    v1.backgroundColor = c6;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
