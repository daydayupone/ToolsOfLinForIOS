//
//  MWViewController.m
//  MWDatePicker
//
//  Created by Marcus on 08.05.13.
//  Copyright (c) 2013 mwermuth.com. All rights reserved.
//

#import "MWViewController.h"

@interface MWViewController ()

@end

@implementation MWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor grayColor]];
//    UIView *hideView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 115, 135)];
//    hideView.backgroundColor = [UIColor grayColor];
//    MWDatePicker *datePicker = [[MWDatePicker alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-110, 55, 220, 135)];
//    [datePicker setDelegate:self];
//    [datePicker setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];
//    [datePicker setFontColor:[UIColor whiteColor]];
//    [datePicker update];
//    
//    [datePicker setDate:[NSDate date] animated:YES];
//    
//    [self.view addSubview:datePicker];
//    [datePicker addSubview:hideView];
    [self creatDatePickerViewWithCGRectMake:CGRectMake([UIScreen mainScreen].bounds.size.width/2-110, 55, 220, 135) andTitle:@"上班时间"];
    [self creatDatePickerViewWithCGRectMake:CGRectMake([UIScreen mainScreen].bounds.size.width/2-110, 275, 220, 135) andTitle:@"下班时间"];
}

- (void)creatDatePickerViewWithCGRectMake:(CGRect)rect
andTitle:(NSString *)title{
    UIView *hideView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 115, 135)];
    hideView.backgroundColor = [UIColor blackColor];
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    titleLb.center = hideView.center;
    titleLb.text = title;
    titleLb.backgroundColor = [UIColor clearColor];
    titleLb.textColor = [UIColor whiteColor];
    [hideView addSubview:titleLb];
    MWDatePicker *datePicker = [[MWDatePicker alloc] initWithFrame:rect];
    [datePicker setDelegate:self];
    [datePicker setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];
    [datePicker setFontColor:[UIColor whiteColor]];
    [datePicker update];
    
    [datePicker setDate:[NSDate date] animated:YES];
    
    [self.view addSubview:datePicker];
    [datePicker addSubview:hideView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MWPickerDelegate

- (UIColor *) backgroundColorForDatePicker:(MWDatePicker *)picker
{
    return [UIColor blackColor];
}


- (UIColor *) datePicker:(MWDatePicker *)picker backgroundColorForComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            return [UIColor blackColor];
        case 1:
            return [UIColor blackColor];
        case 2:
            return [UIColor blackColor];
        default:
            return 0; // never
    }
}


- (UIColor *) viewColorForDatePickerSelector:(MWDatePicker *)picker
{
    return [UIColor grayColor];
}

-(void)datePicker:(MWDatePicker *)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%@",[picker getDate]);
}

@end
