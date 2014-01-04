//
//  GitomViewController.m
//  SecondAndDate
//
//  Created by jiawei on 13-10-10.
//  Copyright (c) 2013年 GitomLJYU. All rights reserved.
//

#import "GitomViewController.h"
#import "TimesTool.h"


@interface GitomViewController ()

@end

@implementation GitomViewController
#pragma mark -- 日期转毫秒
- (IBAction)dateToSecondes:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:self.anDate.text];
    NSLog(@"anDate == %@",date);
    
    long long int dateToSeconde = [TimesTool getEndDateTimeMsWithNSDate:date];
    self.seconds.text = [NSString stringWithFormat:@"%lld",dateToSeconde];
    NSLog(@"long long int second == %lld",dateToSeconde);
}

#pragma mark -- 毫秒转日期
- (IBAction)secondsToDate:(id)sender {
    
    self.anDate01.text = [TimesTool getStrDateTimeWithDateTimeMS:[self.seconds01.text longLongValue]   DateTimeStyle:@"yyyy-MM-dd HH:mm:ss"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.anDate01 setDelegate:self];
    [self.anDate setDelegate:self];
    [self.seconds01 setDelegate:self];
    [self.seconds setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

@end
