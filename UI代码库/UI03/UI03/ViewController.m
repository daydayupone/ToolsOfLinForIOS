//
//  ViewController.m
//  UI03
//
//  Created by ibokan on 13-5-8.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //创建多种颜色的数组,供遍历的时候使用
    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor yellowColor],[UIColor greenColor],[UIColor grayColor],[UIColor purpleColor],[UIColor whiteColor],[UIColor blueColor], nil];
    
    UIView *outView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 330)];
    outView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:outView];
    
    for (int i=1; i<7; i++) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [colorArray objectAtIndex:i-1];//调用数组中的颜色。数组下标是0开始的，所以要减一
        view.frame = CGRectInset(outView.frame, 20*i, 20*i);
        
        [self.view addSubview:view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
