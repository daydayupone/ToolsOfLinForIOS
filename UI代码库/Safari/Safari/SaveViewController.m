//
//  SaveViewController.m
//  Safari
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "SaveViewController.h"
#import "ViewController.h"
#import "Web.h"

@interface SaveViewController ()

@end

@implementation SaveViewController

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
    
    [self.view addSubview:self.url];
    self.title = @"收藏";
    
    //返回item
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = lift;
    
}

//返回按钮
- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

static int a =0;
//存储信息
- (IBAction)saveMyURL:(id)sender {
     
    a++;
    
    NSLog(@"%d",a);
    //存储地址
    [Web andUrl:self.url.text andName:self.name.text andImage:UIImagePNGRepresentation(self.logo.image)];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

- (void)dealloc {
    [_url release];
    [_name release];
    [_logo release];
    [super dealloc];
}
@end
