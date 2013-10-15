//
//  ThirdViewController.m
//  UINavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "ThirdViewController.h"
#import "SingalTon.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
    
    //创建TEXTFile
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(30, 100,80, 40)];
   
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//设置textFile文字设置文字垂直对齐
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    //创建Button
    self.button = [UIButton buttonWithType:1];
    self.button.frame = CGRectMake(110, 100, 40, 40);
    [self.button setTitle:@"提交" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(change ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    //创建Button1
    self.button1 = [UIButton buttonWithType:1];
    self.button1.frame = CGRectMake(110, 100, 40, 40);
    [self.button1 setTitle:@"提交" forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(change ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    
    
    
    
}

- (void) change
{
    SingalTon * ton = [SingalTon getInstance];
    ton.wenBen = self.textField.text;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
