//
//  ViewController.m
//  UI009_UITabBarContrallor
//
//  Created by ibokan on 13-5-27.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "ViewController.h"
#import "SixViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize table;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.view.backgroundColor = [UIColor whiteColor];
    self.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    
    // Dispose of any resources that can be recreated.
}

- (void)push
{
    SixViewController *six = [[SixViewController alloc]init];
    [self.navigationController pushViewController:six animated:YES];
    [six release];
    
}



@end
