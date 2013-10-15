//
//  AddViewController.m
//  UI007_SQList
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "AddViewController.h"
#import "Student.h"//导入Student该类才能使用Student的属性、方法



@interface AddViewController ()

@end

@implementation AddViewController
- (IBAction)addButton:(id)sender {
    self.myDelegate = [[UIApplication sharedApplication]delegate];
    
    
    //[NSNumber numberWithFloat:[self.stuNumber.text floatValue]];
    [self.myDelegate saveStudentName:self.stuName.text andNumber:[NSNumber numberWithFloat:[self.stuNumber.text floatValue]] andPhone:self.stuPone.text andHead:nil];
    NSLog(@"输入框实现数据的输入");
    
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
    [_stuNumber release];
    [super dealloc];
}
@end
