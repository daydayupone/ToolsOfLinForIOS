//
//  ViewController.m
//  UI10_MOVPlayer
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize player,playView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	//获取文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Movie" ofType:@"mp4"];
    //url 和 path 本质上都是文件路径。
    //将path 的文件路径存储进url
    NSURL *url = [[NSURL alloc]initFileURLWithPath:path];
    
    //创建视频播放控制器
    UIGraphicsBeginImageContext(CGSizeMake(1,1));//防止视频BUG
    self.player = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
    UIGraphicsEndImageContext();
    
    //创建一个用来存放视频的视图
    self.playView = [[UIView alloc]initWithFrame:CGRectMake(0, 480, 200, 300)];
    [self.view addSubview:self.playView];
    
    //设置视频播放控制器的格式大小，添加进存放视频的视图
    self.player.moviePlayer.view.frame = CGRectMake(10, 10, 200, 250);
    [playView addSubview:player.moviePlayer.view];
    
    //视频从屏幕下方出现的控制按钮
    UIButton *btn = [UIButton buttonWithType:1];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"play" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn ];
    
}

- (void)push:(id)sender
{
//    [UIView animateWithDuration:1 animations:^{
//        self.playView.center = self.view.center;
//    } ];
    [UIView animateWithDuration:1 animations:^{
        self.playView.center = self.view.center;
    } completion:^(BOOL finished) {
        [self.player.moviePlayer play];
    }];
     
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
