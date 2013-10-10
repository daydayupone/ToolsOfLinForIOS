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
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:self.anDate.text];
    NSLog(@"anDate == %@",date);
    
    long long int dateToSeconde = [TimesTool getTimeMsWithNSDate:date];
    NSLog(@"second == %lld",dateToSeconde);
    
    //self.seconds.text = dateToSeconde
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
