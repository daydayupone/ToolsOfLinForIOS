//
//  ViewController.m
//  UI003
//
//  Created by ibokan on 13-5-10.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //实例一个DrawView的对象dv，获得窗口的大小
    DrawView *dv = [[DrawView alloc]initWithFrame:self.view.frame];
    
    dv.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:dv];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
