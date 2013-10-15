//
//  GCDViewController.m
//  UIGCD_
//
//  Created by ibokan on 13-7-2.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import "GCDViewController.h"
#import "UIImageView+Dispchimage.h"

@interface GCDViewController ()

@end

@implementation GCDViewController


- (IBAction)startGCD:(id)sender {
    
    //GCD线程控制的使用
    [self.img1 setimgURL:@"http://www.xmrc.com.cn/xmrc/xiamen/Place/Huandaolu/200903/W020090315414662144989.jpg"];
    [self.img2 setimgURL:@"http://www.xmrc.com.cn/xmrc/xiamen/Place/Gulangyu/200903/W020090315469662301476.jpg"];
    [self.img3 setimgURL:@"http://www.xmrc.com.cn/xmrc/xiamen/Place/Gulangyu/200903/W020090314583995113026.jpg"];
    [self.img4 setimgURL:@"http://www.xmrc.com.cn/xmrc/xiamen/Place/Gulangyu/200903/W020090314583995113026.jpg"];
    
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
    
    self.title = @"GCD的使用";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
