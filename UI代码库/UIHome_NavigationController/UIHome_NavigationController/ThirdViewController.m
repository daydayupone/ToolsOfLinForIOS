//
//  ThirdViewController.m
//  UIHome_NavigationController
//
//  Created by ibokan on 13-5-22.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
	// Do any additional setup after loading the view.
    
    //初始化并确定一个ScrollView页面的大小
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-20-44)];
    
    scrollView.delegate = self;//将自身作为代理的目的是为了页面效果能够显示当前的页面
    scrollView.contentSize = CGSizeMake(320*5, 480-20-44);//设置页面的长度
    scrollView.pagingEnabled = YES;//一页一页的翻
//    UIButton *aBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    aBt.frame = CGRectMake(200, 200, 130, 40);
//    [aBt addTarget:self action:@selector(abtAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    for (int i=0; i<5; i++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0+320*i, 0, 320, 480-20-44)];
        imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        [scrollView addSubview:imgV];//每个
        
    }
    
    [self.view addSubview:scrollView];
    
    //
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(100, 50, 100, 50)];
    self.pageControl.numberOfPages = 5;
    [self.view addSubview:self.pageControl];
    //[scrollView addSubview:aBt];
}
- (void)abtAction{
    NSLog(@"action");
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    self.pageControl.currentPage = index;
    NSLog(@"index == %d",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
