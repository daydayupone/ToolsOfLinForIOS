//
//  ViewController.m
//  CrashSentBugToMyemail
//
//  Created by jiawei on 13-8-13.
//  Copyright (c) 2013年 GitomLJYU. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


@synthesize ar;

- (IBAction)printToGetError:(id)sender {
    
    
     NSLog(@"ar.count = %@ ",[self.ar objectAtIndex:5]);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ar = @[@1,@3,@4,@5];
   
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
