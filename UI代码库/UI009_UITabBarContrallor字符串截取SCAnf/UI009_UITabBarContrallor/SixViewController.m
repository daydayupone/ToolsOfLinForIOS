//
//  SixViewController.m
//  UI009_UITabBarContrallor
//
//  Created by ibokan on 13-5-27.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "SixViewController.h"
#import "OneViewController.h"
@interface SixViewController ()

@end

@implementation SixViewController

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
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    //创建一个用于导航的按钮
    UIButton *button = [UIButton buttonWithType:1];
    [button setTitle:@"转入第6页" forState:UIControlStateNormal];
    button.frame = CGRectMake(200, 200, 50, 40);
    [button addTarget:self action:@selector(push ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view from its nib.
}

- (void)push
{
    OneViewController *one = [[OneViewController alloc]init];
    [self.navigationController pushViewController:one animated:YES];
    [one release];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

@end
