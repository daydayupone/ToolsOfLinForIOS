//
//  UpdateViewController.m
//  UI007_SQList
//
//  Created by ibokan on 13-5-23.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "UpdateViewController.h"
#import "Student.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController
- (IBAction)updateV:(id)sender {
    //调用Stundent之中定义好的更新方法，
    [Student updateStudentWithName:self.stuName.text andPhone:self.stuPhone.text andId:self.sid];
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
    
    self.stuName.delegate = self;
    self.stuPhone.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    return YES  ;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_stuName release];
    [_stuPhone release];
    [super dealloc];
}
@end
