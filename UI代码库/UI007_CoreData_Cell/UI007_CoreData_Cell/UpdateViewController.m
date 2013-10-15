//
//  UpdateViewController.m
//  UI007_SQList
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "UpdateViewController.h"
#import "Student.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController
- (IBAction)updateV:(id)sender {
    //调用AppDelegate之中定义好的更新方法，
    self.myDelegate = [[UIApplication sharedApplication]delegate];
    NSNumber *x = [[[NSNumberFormatter alloc]init] numberFromString:self.stuNumber.text];
    [self.myDelegate upDataName:self.stuName.text andNumber: x andPhone:self.stuPhone.text andHead:nil];
    
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
    [_stuNumber release];
    [super dealloc];
}
@end
