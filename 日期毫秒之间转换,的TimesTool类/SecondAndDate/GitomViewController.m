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
- (IBAction)dateToSecondes:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:self.anDate.text];
    NSLog(@"anDate == %@",date);
    
    long long int dateToSeconde = [TimesTool getEndDateTimeMsWithNSDate:date];
    NSLog(@"long long int second == %lld",dateToSeconde);
    
    self.seconds.text = [NSString stringWithFormat:@"%lld",dateToSeconde];
    
    NSDateComponents * components = [TimesTool getDateComponentsWithDate:date];
    //[components second];
    NSLog(@"components second %ld",(long)[components second]);
    
    
    long long int dateToSeconde01 = [TimesTool getTimeMsWithNSDate:[NSDate date]];
    NSLog(@"second01  == %lld",dateToSeconde01 );
    
    NSDateComponents * components01 = [TimesTool getDateComponentsWithDate:[NSDate date]];
    NSLog(@"components second01 %ld,%ld,%ld,%ld,%ld,%ld",(long)[components01 second],(long)[components01 minute],(long)[components01 hour],(long)[components01 day],(long)[components01 month],(long)[components01 year]);
    NSLog(@"seconds == %ld", (long)[components01 second]*60 +(long)[components01 minute]*60*60 +(long)[components01 hour]*60*3600+(long)[components01 day]*60*3600*60+(long)[components01 month]*3600*3600*60
    +(long)[components01 year]*3600*3600*3600);
    NSLog(@"2013 == %d",(2013-1970)*3600*3600*3600*1000);
}
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
