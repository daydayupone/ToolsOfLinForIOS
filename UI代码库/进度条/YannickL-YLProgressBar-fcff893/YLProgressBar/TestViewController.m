//
//  TestViewController.m
//  YLProgressBar
//
//  Created by Ibokan on 13-6-24.
//  Copyright (c) 2013年 Yannick Loriot. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}
#pragma mark YLViewController Public Methods

- (void)changeProgressValue
{
    float progressValue = self.testBar.progress;
    progressValue       += 0.05f;
    if (progressValue > 1)
    {
        [progressTimer invalidate];
        //        progressValue = 0;
    }
    [self.testLabel setText:[NSString stringWithFormat:@"%.0f%%", (progressValue * 100)]];
    [self.testBar setProgress:progressValue];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"startup-interface"]];
    self.testBar.frame=CGRectMake(self.testBar.frame.origin.x, self.testBar.frame.origin.y, self.testBar.frame.size.width, self.testBar.frame.size.height+7);
    progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                                          target:self
                                                        selector:@selector(changeProgressValue)
                                                        userInfo:nil
                                                         repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_testBar release];
    [_testLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTestBar:nil];
    [self setTestLabel:nil];
    [super viewDidUnload];
}
@end
