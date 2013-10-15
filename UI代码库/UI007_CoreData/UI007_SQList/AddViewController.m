//
//  AddViewController.m
//  UI007_SQList
//
//  Created by ibokan on 13-5-23.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "AddViewController.h"
#import "Student.h"//导入Student该类才能使用Student的属性、方法

@interface AddViewController ()

@end

@implementation AddViewController
- (IBAction)addButton:(id)sender {
    [Student addStudentWithName:self.stuName.text andPhone:self.stuPone.text];//
}

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_stuName release];
    [_stuPone release];
    [super dealloc];
}
@end
