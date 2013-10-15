//
//  UpateViewController.m
//  ui007
//
//  Created by 颜振洋 on 13-5-23.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "UpateViewController.h"
#import "Student.h"
@interface UpateViewController ()

@end

@implementation UpateViewController
- (IBAction)upateBtn:(id)sender {
    [Student updateStuName:self.txt1.text andStuphone:self.txt2.text andid:self.sid];
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
    [_txt1 release];
    [_txt2 release];
    [super dealloc];
}
@end
